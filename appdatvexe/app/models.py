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
    name_type = models.CharField(max_length=200)

    def __str__(self):
        return self.name_type


class Vehicle(models.Model):
    name = models.CharField(max_length=255, blank=True)
    license_plate = models.CharField(max_length=50, unique=True)
    seat = models.IntegerField()
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
    price = models.DecimalField(max_digits=8, decimal_places=0, null=False)

    def __str__(self):
        return self.name


class Trip(models.Model):
    name = models.CharField(max_length=255, blank=True)
    line = models.ForeignKey(Line, on_delete=models.SET_NULL
                             , null=True, related_name='trips')
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    blank_seat = models.IntegerField()
    driver = models.ForeignKey(User, on_delete=models.SET_NULL
                               , null=True, related_name='driver')

    def __str__(self):
        return self.name


class Ticket(models.Model):
    name = models.CharField(max_length=255, blank=True)
    employee = models.ForeignKey(User, on_delete=models.SET_NULL
                                 , null=True, related_name='employee')
    customer = models.ForeignKey(User, on_delete=models.SET_NULL
                                 , null=True, related_name='customer')
    trip = models.ForeignKey(Trip, on_delete=models.SET_NULL
                                 , null=True, related_name='trip')

    def __str__(self):
        return self.name


class TicketDetail(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.SET_NULL, null=True)
    ticket = models.ForeignKey(Ticket, on_delete=models.SET_NULL, null=True)
    seat_position = models.CharField(max_length=2, null=False)
    note = models.CharField(max_length=255, blank=True)


