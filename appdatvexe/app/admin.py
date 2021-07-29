from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
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


admin_site = AppAdminSite(name="myadmin")
admin_site.register(User, UsersAdmin)
admin_site.register(VehicleType)
admin_site.register(Vehicle)
admin_site.register(Point)
admin_site.register(Line)
admin_site.register(Trip)
admin_site.register(Ticket)
admin_site.register(TicketDetail)
