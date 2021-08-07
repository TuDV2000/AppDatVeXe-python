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
    vehicle_type = models.ForeignKey(VehicleType, on_delete=models.SET_NULL
                                     , null=True, related_name='vehicles')
    tickets = models.ManyToManyField('Ticket', through='TicketDetail'
                                     , through_fields=('vehicle', 'ticket'))

    def __str__(self):
        return "Xe " + self.license_plate


class Point(models.Model):
    address = models.CharField(max_length=255)

    def __str__(self):
        return self.address


class Line(models.Model):
    name = models.CharField(max_length=255, blank=True)
    start_point = models.ForeignKey(Point, on_delete=models.SET_NULL, null=True)
    end_point = models.ForeignKey(Point, on_delete=models.SET_NULL
                                  , null=True, related_name='lines')
    extra_charges = models.IntegerField(default=0)

    def __str__(self):
        return self.name


class Trip(models.Model):
    name = models.CharField(max_length=255, blank=True)
    line = models.ForeignKey(Line, on_delete=models.SET_NULL
                             , null=True, related_name='trips')
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    blank_seat = models.IntegerField()
    price = models.DecimalField(max_digits=8, decimal_places=0, null=False, default=0)
    driver = models.ForeignKey(User, on_delete=models.SET_NULL
                               , null=True, related_name='driver')

    def __str__(self):
        return self.name


class Ticket(models.Model):
    employee = models.ForeignKey(User, on_delete=models.SET_NULL
                                 , null=True, related_name='employee')
    customer = models.ForeignKey(User, on_delete=models.SET_NULL
                                 , null=True, related_name='customer')
    trip = models.ForeignKey(Trip, on_delete=models.SET_NULL
                                 , null=True, related_name='tickets')

    def __str__(self):
        return "Vé " + str(self.trip)


class TicketDetail(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.SET_NULL, null=True)
    ticket = models.ForeignKey(Ticket, related_name="ticket_detail",
                               on_delete=models.CASCADE)
    seat_position = models.CharField(max_length=2, null=False)
    current_price = models.IntegerField(default=0)
    note = models.CharField(max_length=255, blank=True)


