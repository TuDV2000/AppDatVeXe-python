from django.contrib.auth.models import Group
from rest_framework.serializers import ModelSerializer, ImageField
from .models import *


class UserSerializer(ModelSerializer):
    avatar = ImageField(required=True)

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
    class Meta:
        model = Line
        fields = ['id', 'name', 'start_point',
                  'end_point', 'price']
        read_only_fields = ['name', ]

    def create(self, validated_data):
        name = validated_data.get('start_point').address + " - " + validated_data.get('end_point').address
        line = Line(**validated_data, name=name)
        line.save()

        return line


class LineSerializerView(LineSerializer, LineSerializer.Meta):
    start_point = PointSerializer()
    end_point = PointSerializer()


class TripSerializer(ModelSerializer):
    class Meta:
        model = Trip
        fields = ['id', 'name', 'line',
                  'start_time', 'end_time',
                  'blank_seat',  'extra_changes', 'driver']
        read_only_fields = ['name', 'blank_seat', ]

    def create(self, validated_data):
        name = "Chuyến " + validated_data.get('line').name
        blank_seat = validated_data.get('driver').vehicle.all()[0].seat
        trip = Trip(**validated_data, name=name, blank_seat=blank_seat)
        trip.save()

        return trip


class TripSerializerView(TripSerializer, TripSerializer.Meta):
    line = LineSerializer()
    driver = UserSerializer()


class TicketSerializer(ModelSerializer):
    class Meta:
        model = Ticket
        fields = ['id', 'employee', 'customer',
                  'trip', 'created_date']


class TicketSerializerView(TicketSerializer, TicketSerializer.Meta):
    trip = TripSerializerView()
    employee = UserSerializer()
    customer = UserSerializer()


class TicketDetailSerializer(ModelSerializer):
    ticket = TicketSerializerView()

    class Meta:
        model = TicketDetail
        fields = ['id', 'ticket', 'seat_position',
                  'current_price', 'note']


class FeedbackSerializer(ModelSerializer):
    class Meta:
        model = Feedback
        fields = ['id', 'user', 'trip', 'content']


class FeedbackSerializerView(FeedbackSerializer, FeedbackSerializer.Meta):
    user = UserSerializer()
    trip = TripSerializerView()
