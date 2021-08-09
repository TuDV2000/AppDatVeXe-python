from django.contrib import admin
from django.contrib.auth.admin import UserAdmin,GroupAdmin
from django.contrib.auth.models import Group, Permission
from django.utils.html import mark_safe
from .models import *


class AppAdminSite(admin.AdminSite):
    site_header = "Hệ thống đặt vé xe"


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
                '<img src="/static/{url}" width="120" />'.format(url=user.avatar.name)
            )


class VehicleTypeAdmin(admin.ModelAdmin):
    list_display = ['id', 'name_type',]
    search_fields = ['name_type']


class VehicleAdmin(admin.ModelAdmin):
    list_display = ['id', 'license_plate', 'seat'
        , 'vehicle_type', 'extra_charges', 'driver']
    search_fields = ['seat']


class PointAdmin(admin.ModelAdmin):
    list_display = ['id', 'address']
    search_fields = ['address']


class LineAdmin(admin.ModelAdmin):
    list_display = ['id', 'start_point', 'end_point'
        , 'extra_charges']
    search_fields = ['start_point', 'end_point', 'price']


class TripAdmin(admin.ModelAdmin):
    list_display = ['id', 'line', 'start_time'
        , 'end_time', 'price', 'blank_seat', 'driver']
    search_fields = []


class TicketDetailInlineAdmin(admin.StackedInline):
    model = TicketDetail
    fk_name = 'ticket'


class TicketAdmin(admin.ModelAdmin):
    list_display = ['id', 'customer', 'employee', 'trip']
    search_fields = []
    inlines = [TicketDetailInlineAdmin,]


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
admin_site.register(Ticket, TicketAdmin)
admin_site.register(TicketDetail)
