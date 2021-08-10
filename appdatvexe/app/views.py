from django.http import HttpResponse
from rest_framework import viewsets, permissions, status, generics, mixins
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser
from rest_framework.exceptions import PermissionDenied
from django.contrib.auth import logout
from django.contrib.auth.decorators import permission_required
from django.contrib.auth.models import Group, User, Permission
from django.contrib.contenttypes.models import ContentType

from .models import *
from .serializers import *
import datetime


class UserViewSet(viewsets.GenericViewSet,
                  mixins.CreateModelMixin):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]
    permission_classes = [permissions.IsAuthenticated, ]

    @action(methods=["GET"], detail=False,
            url_path="profile", name="profile")
    def profile(self, request):
        if request.user.has_perm("app.view_user"):
            return Response(UserSerializer(request.user).data, status=status.HTTP_200_OK)

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

    def create(self, request, *args, **kwargs):
        if request.data.get("avatar"):
            return super().create(request)

        return Response(data={"Yêu cầu cung cấp hình ảnh của bạn !!"})

    @action(methods=['get'], detail=False,
            url_path="logout")
    def logout(self, request):
        logout(request)
        if request.auth:
            request.auth.revoke()
            return Response(status=status.HTTP_200_OK)

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


class PointViewSet(viewsets.GenericViewSet,
                   mixins.ListModelMixin,
                   mixins.UpdateModelMixin,
                   mixins.DestroyModelMixin):
    queryset = Point.objects.all()
    serializer_class = PointSerializer
    permission_classes = [permissions.IsAuthenticated, ]

    def list(self, request, *args, **kwargs):
        l = Point.objects.all()

        if request.user.has_perm("app.view_point"):
            return Response(PointSerializer(l, many=True).data,
                            status=status.HTTP_200_OK)

        raise PermissionDenied()

    def partial_update(self, request, *args, **kwargs):
        if request.user.has_perm("app.change_point"):
            return super().partial_update(request)

        raise PermissionDenied

    def destroy(self, request, *args, **kwargs):
        if request.user.has_perm("app.delete_point"):
            return super().destroy(request)

        raise PermissionDenied


class LineViewSet(viewsets.GenericViewSet,
                  mixins.ListModelMixin,
                  mixins.UpdateModelMixin,
                  mixins.DestroyModelMixin):
    queryset = Line.objects.all()
    serializer_class = LineSerializer
    permission_classes = [permissions.IsAuthenticated, ]

    def list(self, request, *args, **kwargs):
        l = Line.objects.all()

        if request.user.has_perm("app.view_line"):
            return Response(LineSerializer(l, many=True).data,
                            status=status.HTTP_200_OK)

        raise PermissionDenied()

    def partial_update(self, request, *args, **kwargs):
        if request.user.has_perm("app.change_line"):
            return super().partial_update(request)

        raise PermissionDenied

    def destroy(self, request, *args, **kwargs):
        if request.user.has_perm("app.delete_line"):
            return super().destroy(request)

        raise PermissionDenied


class TripViewSet(viewsets.GenericViewSet,
                  mixins.ListModelMixin,
                  mixins.DestroyModelMixin,
                  mixins.RetrieveModelMixin):
    queryset = Trip.objects.all()
    serializer_class = TripSerializer
    permission_classes = [permissions.IsAuthenticated, ]

    def list(self, request, *args, **kwargs):
        l = Trip.objects.all()

        if request.user.has_perm("app.view_trip"):
            return Response(TripSerializer(l, many=True).data,
                            status=status.HTTP_200_OK)

        raise PermissionDenied()

    def partial_update(self, request, *args, **kwargs):
        if request.user.has_perm("app.change_trip"):
            return super().partial_update(request)

        raise PermissionDenied

    def destroy(self, request, *args, **kwargs):
        if request.user.has_perm("app.delete_trip"):
            return super().destroy(request)

        raise PermissionDenied

    @action(methods=['post'], detail=True,
            url_path="feedback")
    def feedback(self, request, pk):
        u = request.user
        t = Trip.objects.get(pk=pk)

        if u.has_perm("app.add_feedback"):
            if request.data.get("content") == None:
                return Response(data={"Lỗi !! Vui lòng nhập nội dung phản hồi"})
            f = Feedback(user=u, trip=t, content=request.data.get("content"))
            if f:
                f.save()
                return Response(FeedbackSerializer(f).data,
                                status=status.HTTP_200_OK)
            return Response(data={"Lỗi !! Không thể tạo phản hồi"})

        raise PermissionDenied

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
                current_price = trip.price + trip.line.extra_charges + vehicle.extra_charges
                TicketDetail.objects.create(vehicle=vehicle, ticket=ticket, seat_position=seat_position
                                            , current_price=current_price
                                            , note="Vui lòng đến trước giờ bắt đầu 15' !!")
                trip.save()
                return Response(TicketSerializer(ticket).data
                                , status=status.HTTP_200_OK)
            else:
                return Response(data={"Chuyến xe đã hết chổ. Vui lòng đợi chuyến xe."})
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
                        current_price = trip.price + trip.line.extra_charges + vehicle.extra_charges
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
            return Response(data={"Bạn không được phép ở đây !!"})

    @action(methods=['post'], detail=False
            ,url_path="search-by-time")
    def search_by_time(self, request):
        d, m, y = int(request.data.get('day')), int(request.data.get('month')), int(request.data.get('year'))
        if d and m and y:
            trips = list(Trip.objects.filter(start_time__date=datetime.datetime(y, m, d)))
            if trips:
                return Response(TripSerializer(trips, many=True).data, status=status.HTTP_200_OK)

            return Response(data={"Lỗi !!! không lấy được trips."})

        return Response(data={"Lỗi !!! không lấy được ngày tháng năm."})

    @action(methods=['post'], detail=False
        , url_path="search-by-point")
    def search_by_point(self, request):
        start_point = request.data.get("start_point")
        end_point = request.data.get("end_point")
        if start_point:
            if end_point:
                trips = Trip.objects.filter(line__start_point__address=start_point, line__end_point__address=end_point)
                if trips:
                    return Response(TripSerializer(trips, many=True).data, status=status.HTTP_200_OK)

                return Response(data={"Lỗi !!! không lấy được trips."})

            return Response(data={"Lỗi !!! không lấy được điểm đến."})
        return Response(data={"Lỗi !!! không lấy được điểm đi."})

    def get_serializer_class(self):
        if self.action == "book_ticket":
            return TicketSerializer

        return super().get_serializer_class()


class TicketViewSet(viewsets.GenericViewSet,
                    mixins.ListModelMixin,
                    mixins.RetrieveModelMixin,
                    mixins.DestroyModelMixin,
                    mixins.CreateModelMixin):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    permission_classes = [permissions.IsAuthenticated, ]

    def list(self, request, *args, **kwargs):
        l = Ticket.objects.all()

        if request.user.has_perm("app.view_ticket"):
            return Response(TicketSerializer(l, many=True).data,
                            status=status.HTTP_200_OK)

        raise PermissionDenied()

    @action(methods=['get'], detail=True,
            url_path="detail")
    def get_ticket_detail(self, request, pk):
        try:
            ticket_detail = TicketDetail.objects.get(ticket=int(pk))
            return Response(TicketDetailSerializer(ticket_detail).data,
                            status=status.HTTP_200_OK)
        except TicketDetail.DoesNotExist:
            return Response(data={"Loi"},
                            status=status.HTTP_400_BAD_REQUEST)

    def destroy(self, request, *args, **kwargs):
        if request.user.has_perm("app.delete_ticket"):
            return super().destroy(request)

        raise PermissionDenied

    def get_serializer_class(self):
        if self.action == "get_ticket_detail":
            return TicketDetailSerializer

        return super().get_serializer_class()


class FeedbackViewSet(viewsets.GenericViewSet,
                    mixins.ListModelMixin):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    permission_classes = [permissions.IsAuthenticated, ]

