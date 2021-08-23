from django.db import utils
from django.db.models import Q
from django.http import HttpResponse
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, permissions, status, generics, mixins, filters
from rest_framework.decorators import action
from rest_framework.filters import SearchFilter
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser
from rest_framework.exceptions import PermissionDenied
from django.contrib.auth import logout
from django.contrib.auth.models import Group, User, Permission
from django.contrib.contenttypes.models import ContentType

from .permissions_custom import *
from .DjangoFilterCustom import DjangoFilterCustom
from .models import *
from .serializers import *
import datetime


class UserViewSet(viewsets.GenericViewSet,
                  mixins.CreateModelMixin):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]

    def create(self, request, *args, **kwargs):
        if request.data.get("avatar"):
            return super().create(request)

        return Response(data={"Yêu cầu cung cấp hình ảnh của bạn !!"})

    @action(methods=["GET"], detail=False,
            url_path="profile", name="profile")
    def profile(self, request):
        if request.user.has_perm("app.view_user"):
            return Response(UserSerializer(request.user).data, status=status.HTTP_200_OK)

        raise PermissionDenied

    @action(methods=['post'], detail=False,
            url_path="change-profile")
    def change_profile(self, request):
        u = request.user

        if u.has_perm("app.change_user"):
            if request.data.get("new_email"):
                u.email = request.data.get("new_email")
            if request.data.get("new_address"):
                u.address = request.data.get("new_address")
            if request.data.get("new_number_pho ne"):
                u.number_phone = request.data.get("new_number_phone")
            u.save()

            return Response(status=status.HTTP_200_OK)

        raise PermissionDenied

    @action(methods=['post'], detail=False,
            url_path="change-password")
    def change_password(self, request):
        u = request.user

        if u.has_perm("app.change_user"):
            old_pass = request.data.get("old_pass")
            new_pass = request.data.get("new_pass")
            confirm = request.data.get("confirm")
            if old_pass and new_pass and confirm:
                if u.check_password(old_pass):
                    if new_pass == confirm:
                        u.set_password(new_pass)
                        u.save()
                        self.logout(request)
                        return Response(status=status.HTTP_200_OK)
                    else:
                        return Response(data={"error": "Lỗi!! xác nhận mật khẩu không trùng khớp."},
                                        status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response(data={"error": "Lỗi!! mật khẩu không đúng."},
                                    status=status.HTTP_400_BAD_REQUEST)

            return Response(data={"error": "Lỗi!! Vui lòng nhập đầy đủ thông tin."},
                            status=status.HTTP_400_BAD_REQUEST)

        raise PermissionDenied

    @action(methods=['get'], detail=False,
            url_path="logout")
    def logout(self, request):
        logout(request)
        if request.auth:
            request.auth.revoke()
            return Response(status=status.HTTP_200_OK)


class PointViewSet(viewsets.GenericViewSet,
                   mixins.ListModelMixin,
                   mixins.UpdateModelMixin,
                   mixins.CreateModelMixin,
                   mixins.DestroyModelMixin):
    queryset = Point.objects.filter(is_active=True)
    serializer_class = PointSerializer
    filter_backends = [SearchFilter]
    permission_classes = [PointPermissions, ]

    #todo: destroy

    search_fields = [
        'address',
    ]


class LineViewSet(viewsets.GenericViewSet,
                  mixins.ListModelMixin,
                  mixins.UpdateModelMixin,
                  mixins.CreateModelMixin,
                  mixins.DestroyModelMixin):
    queryset = Line.objects.filter(is_active=True)
    serializer_class = LineSerializer
    filter_backends = [SearchFilter, DjangoFilterBackend, ]
    permission_classes = [LinePermissions, ]

    # todo: destroy

    search_fields = [
        'start_point__address', 'end_point__address'
    ]

    filterset_fields = [
        'start_point', 'end_point'
    ]

    def get_permissions(self):
        if self.action in ['list']:
            return [permissions.AllowAny(), ]

        return super(LineViewSet, self).get_permissions()

    def get_serializer_class(self):
        if self.action == 'list':
            return LineSerializerView

        return LineSerializer

    def update(self, request, *args, **kwargs):
        price = request.data.get('price')
        if price:
            line = self.get_object()
            if line:
                line.price = price
                line.save()
                return Response(status=status.HTTP_200_OK)
            return Response(data={"Lỗi!! Không thể cập nhật tuyến."}
                        , status=status.HTTP_400_BAD_REQUEST)

        return Response(status=status.HTTP_204_NO_CONTENT)


class TripViewSet(viewsets.GenericViewSet,
                  mixins.ListModelMixin,
                  mixins.UpdateModelMixin,
                  mixins.CreateModelMixin,
                  mixins.RetrieveModelMixin):
    queryset = Trip.objects.filter(is_active=True)
    serializer_class = TripSerializer
    filter_backends = [SearchFilter, DjangoFilterCustom]
    permission_classes = [TripPermissions, ]

    # todo: destroy

    search_fields = [
        'line__end_point__address'
    ]

    filterset_fields = [
        'line', 'start_time', 'end_time'
    ]

    def get_serializer_class(self):
        if self.action in ['book_ticket', 'sell_ticket']:
            return TicketSerializerView
        if self.action in ['list', 'retrieve']:
            return TripSerializerView
        if self.action == 'get_feedbacks':
            return FeedbackSerializerView

        return super(TripViewSet, self).get_serializer_class()

    def get_permissions(self):
        if self.action in ['list', 'retrieve']:
            return [permissions.AllowAny(), ]
        if self.action in ['book_ticket', 'sell_ticket']:
            return [TicketPermissions(), ]

        return super(TripViewSet, self).get_permissions()

    def update(self, request, *args, **kwargs):
        extra_changes = request.data.get('extra_changes')
        if extra_changes:
            trip = self.get_object()
            if trip:
                trip.extra_changes = extra_changes
                trip.save()
                return Response(status=status.HTTP_200_OK)
            return Response(data={"Lỗi!! Không thể cập nhật chuyến xe."}
                            , status=status.HTTP_400_BAD_REQUEST)

        return Response(status=status.HTTP_204_NO_CONTENT)

    @action(methods=['post'], detail=True
            , url_path="book-ticket")
    def book_ticket(self, request, pk):
        trip = Trip.objects.get(pk=pk)
        if trip:
            if trip.blank_seat > 0:
                trip.blank_seat -= 1
                vehicle = trip.driver.vehicle.all()[0]
                ticket = Ticket(customer=request.user, trip=trip)
                ticket.save()

                seat_position = vehicle.seat - trip.blank_seat
                current_price = trip.extra_changes + trip.line.price + vehicle.extra_changes
                TicketDetail.objects.create(vehicle=vehicle, ticket=ticket, seat_position=seat_position
                                            , current_price=current_price
                                            , note="Vui lòng đến trước giờ bắt đầu 15' !!")
                trip.save()
                return Response(self.get_serializer(ticket).data
                                , status=status.HTTP_200_OK)
            else:
                return Response(data={"Chuyến xe đã hết chổ. Vui lòng đặt vé chuyến xe tiếp theo."})
        return Response(data={"Lỗi !! Không thể lấy được chuyến đi này."})

    @action(methods=['post'], detail=True
        , url_path="sell-ticket")
    def sell_ticket(self, request, pk):
        u = request.user
        try:
            if u.groups.get(name="employee"):
                trip = Trip.objects.get(pk=pk)
                if trip:
                    if trip.blank_seat > 0:
                        trip.blank_seat -= 1
                        vehicle = trip.driver.vehicle.all()[0]
                        ticket = Ticket(customer=u, trip=trip)
                        ticket.save()

                        seat_position = vehicle.seat - trip.blank_seat
                        current_price = trip.extra_changes + trip.line.price + vehicle.extra_changes
                        TicketDetail.objects.create(vehicle=vehicle, ticket=ticket, seat_position=seat_position
                                                    , current_price=current_price
                                                    , note="Vui lòng đến trước giờ bắt đầu 15' !!")
                        trip.save()
                        return Response(TicketSerializer(ticket).data
                                        , status=status.HTTP_200_OK)
                    else:
                        return Response(data={"Chuyến xe đã hết chổ."})
                return Response(data={"Lỗi !! Không thể lấy được chuyến đi này."})
        except Group.DoesNotExist:
            return Response(data={"Lỗi!! Bạn không phải nhân viên."})

    @action(methods=['get'], detail=True,
            url_path='feedbacks')
    def get_feedbacks(self, request, pk):
        trip = self.get_object()
        feedbacks = Feedback.objects.filter(trip=trip)
        if feedbacks:
            return Response(FeedbackSerializerView(feedbacks, many=True).data,
                            status=status.HTTP_200_OK)

        return Response(data={'Lỗi!! Không lấy được danh sách phản hồi của chuyến xe này'},
                            status=status.HTTP_400_BAD_REQUEST)


class TicketViewSet(viewsets.GenericViewSet,
                    mixins.ListModelMixin,
                    mixins.RetrieveModelMixin):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    permission_classes = [TicketPermissions, ]

    def get_serializer_class(self):
        if self.action == "get_ticket_detail":
            return TicketDetailSerializer
        if self.action in ['list', 'retrieve']:
            return TicketSerializerView
        if self.action == 'feedback':
            return FeedbackSerializer

        return super(TicketViewSet, self).get_serializer_class()

    def get_permissions(self):
        if self.action in ['retrieve', 'list']:
            return [TicketPermissions(), ]
        if self.action == 'feedback':
            return [CustomerFeedbackPermissions(), ]

        return super(TicketViewSet, self).get_permissions()

    def list(self, request, *args, **kwargs):
        user_current = request.user
        tickets = Ticket.objects.filter(Q(employee=user_current) | Q(customer=user_current))

        if tickets:
            return Response(TicketSerializerView(tickets, many=True).data
                            , status=status.HTTP_200_OK)

        return Response(data={"Lỗi! Không có đữ liệu đặt vé."})

    def retrieve(self, request, *args, **kwargs):
        ticket = self.get_object()

        if self.check_ticket(request, ticket):
            return super(TicketViewSet, self).retrieve(request, *args, **kwargs)

        return Response(data={"Lỗi!! Đây không phải vé của bạn."}
                        , status=status.HTTP_400_BAD_REQUEST)

    @action(methods=['get'], detail=True, url_path="detail")
    def get_ticket_detail(self, request, pk):
        try:
            ticket = Ticket.objects.get(pk=pk)
            if self.check_ticket(request, ticket):
                ticket_detail = TicketDetail.objects.get(ticket=ticket)
                return Response(TicketDetailSerializer(ticket_detail).data
                                , status=status.HTTP_200_OK)
            return Response(data={"Lỗi!! Đây không phải vé của bạn."}
                            , status=status.HTTP_400_BAD_REQUEST)
        except TicketDetail.DoesNotExist:
            return Response(data={"Lỗi!! Vé không tồn tại."}
                            , status=status.HTTP_400_BAD_REQUEST)

    '''
        Phương thức kiểm tra ticket có đúng là của user hay không
            + Nếu user_current là customer -> True
            + Nếu user_current là employee -> True
    '''
    def check_ticket(self, request, instance):
        user = request.user
        ticket = instance
        if ticket.customer:
            if user.pk == ticket.customer.pk:
                return True
        else:
            if user.pk == ticket.employee.pk:
                return True

        return False

    @action(methods=['post'], detail=True,
            url_path="feedback")
    def feedback(self, request, pk):
        try:
            u = request.user
            ticket = self.get_object()
            if u.has_perms(['app.view_feedback', 'app.add_feedback']):
                if self.check_ticket(request, ticket):
                    if not request.data.get("content"):
                        return Response(data={"Lỗi !! Vui lòng nhập nội dung phản hồi."})
                    f = Feedback(user=u, trip=ticket.trip, content=request.data.get("content"))
                    if f:
                        f.save()
                        return Response(FeedbackSerializer(f).data,
                                        status=status.HTTP_200_OK)
                    return Response(data={"Lỗi !! Không thể phản hồi"})
                return Response(data={"Lỗi !! Đây không phải vé của bạn."})

            raise PermissionDenied
        except utils.IntegrityError:
            return Response(data={"Lỗi !! Bạn đã phản hồi chuyến xe này."})


class FeedbackViewSet(viewsets.GenericViewSet,
                      mixins.ListModelMixin,
                      mixins.RetrieveModelMixin,
                      mixins.UpdateModelMixin):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializerView
    permission_classes = [CustomerFeedbackPermissions, ]

    def list(self, request, *args, **kwargs):
        user = request.user
        queryset = Feedback.objects.filter(user=user)
        if queryset:
            self.queryset = queryset
            return super(FeedbackViewSet, self).list(request, *args, **kwargs)

        return Response(data={"Bạn chưa có phản hồi nào!"})

    def update(self, request, *args, **kwargs):
        content = request.data.get('content')
        user = request.user
        feedback = self.get_object()
        if feedback.user == user:
            if content:
                feedback.content = content
                feedback.save()
                return Response(status=status.HTTP_200_OK)

            return Response(status=status.HTTP_204_NO_CONTENT)

        return Response(data={'Lỗi! Đây không phải phản hồi của bạn.'},
                        status=status.HTTP_400_BAD_REQUEST)

