from rest_framework.serializers import ModelSerializer
from .models import *


class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name'
                  , 'email', 'avatar', 'is_active', 'date_joined']


class PointSerializer(ModelSerializer):
    class Meta:
        model = Point
        fields = ['id', 'address']


class LineSerializer(ModelSerializer):
    start_point = PointSerializer()
    end_point = PointSerializer()

    class Meta:
        model = Line
        fields = ['id', 'name', 'start_point'
                  , 'end_point', 'extra_charges']


class TripSerializer(ModelSerializer):
    line = LineSerializer()
    driver = UserSerializer()

    class Meta:
        model = Trip
        fields = ['id', 'name', 'line'
                  , 'start_time', 'end_time'
                  , 'blank_seat', 'price', 'driver']


class TicketSerializer(ModelSerializer):
    class Meta:
        model = Ticket
        fields = ['id', 'employee', 'customer'
                  , 'trip']

