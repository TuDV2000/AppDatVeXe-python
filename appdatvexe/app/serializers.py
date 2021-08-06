from django.contrib.auth.models import Group
from rest_framework.serializers import ModelSerializer
from .models import *


class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name',
                  'username', 'password', 'email',
                  'avatar']
        extra_kwargs = {
            'password': {'write_only': 'true'}
        }

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        user.groups.add(Group.objects.get(name="customer"))

        return user


class PointSerializer(ModelSerializer):
    class Meta:
        model = Point
        fields = ['id', 'address']


class LineSerializer(ModelSerializer):
    start_point = PointSerializer()
    end_point = PointSerializer()

    class Meta:
        model = Line
        fields = ['id', 'name', 'start_point',
                  'end_point', 'extra_charges']


class TripSerializer(ModelSerializer):
    line = LineSerializer()
    driver = UserSerializer()

    class Meta:
        model = Trip
        fields = ['id', 'name', 'line',
                  'start_time', 'end_time',
                  'blank_seat', 'price', 'driver']


class TicketSerializer(ModelSerializer):
    class Meta:
        model = Ticket
        fields = ['id', 'employee', 'customer',
                  'trip']


class TicketDetailSerializer(ModelSerializer):
    class Meta:
        model = TicketDetail
        fields = ['id', 'ticket', 'seat_position',
                  'current_price', 'note']