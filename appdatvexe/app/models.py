from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    dob = models.DateTimeField(null=True)
    gender = models.CharField(max_length=10, null=True)
    address = models.CharField(max_length=255, null=True)
    identity_card = models.CharField(max_length=10, null=True)
    number_phone = models.CharField(max_length=10, null=True)
    avatar = models.ImageField(upload_to="images/%Y/%m", null=True)


class VehicleType(models.Model):
    name_type = models.CharField(max_length=200, unique=True)

    def __str__(self):
        return self.name_type


class Vehicle(models.Model):
    license_plate = models.CharField(max_length=50, unique=True)
    seat = models.IntegerField()
    extra_charges = models.IntegerField(default=0)
    vehicle_type = models.ForeignKey(VehicleType, on_delete=models.SET_NULL,
                                     null=True, related_name='vehicles')
    tickets = models.ManyToManyField('Ticket', through='TicketDetail',
                                     through_fields=('vehicle', 'ticket'))
    driver = models.ForeignKey(User, on_delete=models.SET_NULL,
                               null=True, related_name="vehicle", unique=True)

    def __str__(self):
        return "Xe " + self.license_plate


class Point(models.Model):
    address = models.CharField(max_length=255)

    def __str__(self):
        return self.address


class Line(models.Model):
    name = models.CharField(max_length=255, blank=True)
    start_point = models.ForeignKey(Point, on_delete=models.SET_NULL,
                                    related_name="line_start", null=True)
    end_point = models.ForeignKey(Point, on_delete=models.SET_NULL,
                                  related_name='line_end', null=True)
    extra_charges = models.IntegerField(default=0)

    def __str__(self):
        return self.name


class Trip(models.Model):
    name = models.CharField(max_length=255, blank=True)
    line = models.ForeignKey(Line, on_delete=models.SET_NULL, null=True,
                             related_name='line_trips')
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    blank_seat = models.IntegerField()
    price = models.DecimalField(max_digits=8, decimal_places=0, null=False, default=0)
    driver = models.ForeignKey(User, on_delete=models.SET_NULL, null=True,
                               related_name='driver_trips')

    def __str__(self):
        return self.name


class Ticket(models.Model):
    employee = models.ForeignKey(User, on_delete=models.SET_NULL, null=True,
                                 related_name='employee_tickets')
    customer = models.ForeignKey(User, on_delete=models.SET_NULL, null=True,
                                 related_name='customer_tickets')
    trip = models.ForeignKey(Trip, on_delete=models.SET_NULL, null=True,
                             related_name='trip_tickets')
    created_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "Vé " + str(self.trip)


class TicketDetail(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.SET_NULL, null=True)
    ticket = models.ForeignKey(Ticket, related_name="ticket_detail",
                               on_delete=models.CASCADE)
    seat_position = models.CharField(max_length=2, null=False)
    current_price = models.IntegerField(default=0)
    note = models.CharField(max_length=255, blank=True)


class Feedback(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True,
                             related_name="feedback_user")
    trip = models.ForeignKey(Trip, on_delete=models.SET_NULL, null=True,
                             related_name="feedback_trip")
    content = models.TextField()

    def __str__(self):
        return "Phản hồi " + self.trip.name + " của " + self.user.username
