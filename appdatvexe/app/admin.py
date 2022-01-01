import datetime

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin,GroupAdmin
from django.contrib.auth.models import Group, Permission
from django.utils.html import mark_safe
from .models import *
from django.urls import path
from django.template.response import TemplateResponse
from django.http import JsonResponse
from rest_framework import status


class AppAdminSite(admin.AdminSite):
    site_header = "Hệ thống đặt vé xe"

    def get_urls(self):
        return [
                    path('stats/', self.stats),
                    path('stats/trips', self.stats_trips_by_line),
                    path('stats/month', self.stats_month_by_year),
                    path('stats/quarter', self.stats_quarter_by_year)
               ] + super().get_urls()

    def stats(self, request, **kwargs):
        context = {'years_have_turnover': self.get_year_has_turnover()}
        return TemplateResponse(request, 'admin/stats.html', context, **kwargs)

    def stats_month_by_year(self, request, **kwargs):
        try:
            year = int(request.GET.get("year"))
            data = self.get_turnover_month_of_year(year)
            print(data)
            return JsonResponse(data, status=status.HTTP_200_OK)
        except:
            return JsonResponse({"error": "Năm không hợp lệ"}, status=status.HTTP_400_BAD_REQUEST)

    def stats_quarter_by_year(self, request, **kwargs):
        try:
            year = int(request.GET.get("year"))
            data = self.get_turnover_quarter_of_year(year)
            return JsonResponse(data, status=status.HTTP_200_OK)
        except:
            return JsonResponse({"error": "Năm không hợp lệ"}, status=status.HTTP_400_BAD_REQUEST)

    def stats_trips_by_line(self, request, **kwargs):
        data = {}
        lines = Line.objects.all()

        if lines:
            for l in lines:
                trips = Trip.objects.filter(line=l)
                if len(trips) > 0:
                    data[l.pk] = len(trips)

        return JsonResponse(data, status=status.HTTP_200_OK)

    def get_turnover_month_of_year(self, year=datetime.datetime.now().year):
        if type(year) is int:
            data = {}
            month = [t.month for t in
                     Ticket.objects.filter(created_date__year=year).dates("created_date", "month")]

            for m in month:
                tickets = Ticket.objects.filter(created_date__year=year, created_date__month=m);
                total = 0
                for t in tickets:
                    total += t.ticket_detail.all()[0].current_price
                data[str(m)] = total;

            return data
        return {"data": []}

    def get_turnover_quarter_of_year(self, year=datetime.datetime.now().year):
        if type(year) is int:
            data = {}
            quarter = 1
            for i in range(1, 12, 3):
                tickets = Ticket.objects.filter(created_date__year=year
                                                     , created_date__month__gte=i
                                                     , created_date__month__lte=i + 2);
                total = 0
                for t in tickets:
                    total += t.ticket_detail.all()[0].current_price

                data[quarter] = total
                quarter += 1

            return data
        return {"data": []}

    def get_year_has_turnover(self):
        return [t.year for t in Ticket.objects.dates("created_date", "year", "ASC")]


class UsersAdmin(UserAdmin):
    list_display = ['id', 'first_name', 'last_name'
        , 'email', 'is_active']
    readonly_fields = ['show_avatar',]

    def get_fieldsets(self, request, obj=None):
        if not obj:
            return self.add_fieldsets
        return super().get_fieldsets(request, obj) + (
            (("Image"), {'fields': ('avatar', "show_avatar")}),
        )

    def show_avatar(self, user):
        if user:
            return mark_safe(
                '<img src="{url}" width="120" />'.format(url=user.avatar.url)
            )


class VehicleTypeAdmin(admin.ModelAdmin):
    list_display = ['id', 'name_type',]
    search_fields = ['name_type']


class VehicleAdmin(admin.ModelAdmin):
    list_display = ['id', 'license_plate', 'seat'
        , 'vehicle_type', 'extra_changes', 'driver']
    search_fields = ['seat']


class PointAdmin(admin.ModelAdmin):
    list_display = ['id', 'address']
    search_fields = ['address']


class LineAdmin(admin.ModelAdmin):
    list_display = ['id', 'start_point', 'end_point'
        , 'price']
    search_fields = ['start_point', 'end_point', 'price']


class TripAdmin(admin.ModelAdmin):
    list_display = ['id', 'line', 'start_time'
        , 'end_time', 'extra_changes', 'blank_seat', 'driver']
    search_fields = []


class TicketDetailAdmin(admin.ModelAdmin):
    list_display = ['id', 'seat_position', 'current_price'
        , 'vehicle', 'ticket']
    search_fields = []


class TicketDetailInlineAdmin(admin.StackedInline):
    model = TicketDetail
    fk_name = 'ticket'


class TicketAdmin(admin.ModelAdmin):
    list_display = ['id', 'customer', 'employee', 'trip']
    search_fields = []
    inlines = [TicketDetailInlineAdmin,]


class FeedbackAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'trip']
    search_fields = []


class UserInGroupAdmin(admin.StackedInline):
    model = Group.user_set.through


class CustomGroupAdmin(GroupAdmin):
    list_display = ['name',]
    inlines = [UserInGroupAdmin,]


admin_site = AppAdminSite(name="myadmin")
admin_site.register(Group, CustomGroupAdmin)
admin_site.register(Permission)
admin_site.register(User, UsersAdmin)
admin_site.register(VehicleType, VehicleTypeAdmin)
admin_site.register(Vehicle, VehicleAdmin)
admin_site.register(Point, PointAdmin)
admin_site.register(Line, LineAdmin)
admin_site.register(Trip, TripAdmin)
admin_site.register(Feedback, FeedbackAdmin)
admin_site.register(Ticket, TicketAdmin)
admin_site.register(TicketDetail, TicketDetailAdmin)

