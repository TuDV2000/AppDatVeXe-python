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


class UserViewSet(viewsets.GenericViewSet,
                  mixins.CreateModelMixin):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]
    permission_classes = [permissions.IsAuthenticated, ]

    @action(methods=["GET"], detail=False,
            url_path="profile", name="profile")
    def profile(self, request):
        return Response(UserSerializer(request.user).data, status=status.HTTP_200_OK)

    @action(methods=['post'], detail=False,
            url_path="change-password")
    def change_password(self, request):
        old_pass = request.data.get("old_pass")
        new_pass = request.data.get("new_pass")
        confirm = request.data.get("confirm")
        if old_pass and new_pass and confirm:
            u = request.user
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
        if request.data.get("new_email"):
            u.email = request.data.get("new_email")
        if request.data.get("new_address"):
            u.address = request.data.get("new_address")
        if request.data.get("new_number_pho ne"):
            u.number_phone = request.data.get("new_number_phone")
        u.save()

        return Response(status=status.HTTP_200_OK)


class PointViewSet(viewsets.GenericViewSet,
                   mixins.ListModelMixin):
    queryset = Point.objects.all()
    serializer_class = PointSerializer
    permission_classes = [permissions.IsAuthenticated, ]

    def list(self, request, *args, **kwargs):
        l = Point.objects.all()

        if request.user.has_perm("app.view_point"):
            return Response(PointSerializer(l, many=True).data,
                            status=status.HTTP_200_OK)

        raise PermissionDenied()


class LineViewSet(viewsets.GenericViewSet,
                  mixins.ListModelMixin):
    queryset = Line.objects.all()
    serializer_class = LineSerializer
    permission_classes = [permissions.IsAuthenticated, ]

    def list(self, request, *args, **kwargs):
        l = Line.objects.all()

        if request.user.has_perm("app.view_line"):
            return Response(LineSerializer(l, many=True).data,
                            status=status.HTTP_200_OK)

        raise PermissionDenied()


class TripViewSet(viewsets.GenericViewSet,
                  mixins.ListModelMixin):
    queryset = Trip.objects.all()
    serializer_class = TripSerializer
    permission_classes = [permissions.IsAuthenticated, ]

    def list(self, request, *args, **kwargs):
        l = Trip.objects.all()

        if request.user.has_perm("app.view_trip"):
            return Response(TripSerializer(l, many=True).data,
                            status=status.HTTP_200_OK)

        raise PermissionDenied()


class TicketViewSet(viewsets.GenericViewSet,
                    mixins.ListModelMixin,
                    mixins.RetrieveModelMixin):
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

    def get_serializer_class(self):
        if self.action == "get_ticket_detail":
            return TicketDetailSerializer

        return super().get_serializer_class()