from django.shortcuts import render
from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response

from .models import *
from .serializers import *


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer

    def get_permissions(self):
        if self.action == 'list':
            return [permissions.AllowAny()]

        return [permissions.IsAuthenticated()]

    @action(methods=['post'], detail=True
        , url_path='deny-user', url_name='deny-user')
    def deny_user(self, request, pk):
        try:
            u = User.objects.get(pk=pk)
            u.is_active = False
            u.save()
        except User.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=UserSerializer(u).data
                        , status=status.HTTP_200_OK)


class PointViewSet(viewsets.ModelViewSet):
    queryset = Point.objects.all()
    serializer_class = PointSerializer


class LineViewSet(viewsets.ModelViewSet):
    queryset = Line.objects.all()
    serializer_class = LineSerializer


class TripViewSet(viewsets.ModelViewSet):
    queryset = Trip.objects.all()
    serializer_class = TripSerializer


class TicketViewSet(viewsets.ModelViewSet):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer

