from rest_framework.permissions import IsAuthenticated


class PointPermissions(IsAuthenticated):

    def has_permission(self, request, view):
        return super(PointPermissions, self).has_permission(request, view) \
               and request.user.has_perms(["app.change_point", "app.delete_point", "app.add_point"])


class LinePermissions(IsAuthenticated):

    def has_permission(self, request, view):
        return super(LinePermissions, self).has_permission(request, view) \
               and request.user.has_perms(["app.change_line", "app.delete_line", "app.add_line"])


class TripPermissions(IsAuthenticated):

    def has_permission(self, request, view):
        return super(TripPermissions, self).has_permission(request, view) \
               and request.user.has_perms(["app.change_trip", "app.delete_trip", "app.add_trip"])


class TicketPermissions(IsAuthenticated):

    def has_permission(self, request, view):
        return super(TicketPermissions, self).has_permission(request, view) \
               and request.user.has_perms(["app.view_ticket", 'app.add_ticket'])


class CustomerFeedbackPermissions(IsAuthenticated):

    def has_permission(self, request, view):
        return super(CustomerFeedbackPermissions, self).has_permission(request, view) \
               and request.user.has_perms(["app.view_feedback", 'app.add_feedback', 'app.change_feedback',
                                           'app.delete_feedback'])


class EmployeeFeedbackPermissions(CustomerFeedbackPermissions):

    def has_permission(self, request, view):
        return super(EmployeeFeedbackPermissions, self).has_permission(request, view) \
               and request.user.groups.get(name="employee")


class StatsPermissions(IsAuthenticated):

    def has_permission(self, request, view):
        return super(StatsPermissions, self).has_permission(request, view) \
               and request.user.has_perms(['app.stats'])
