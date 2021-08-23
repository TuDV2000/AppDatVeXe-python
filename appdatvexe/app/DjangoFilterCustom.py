import datetime

import rest_framework.exceptions
from django_filters.rest_framework import DjangoFilterBackend

from .models import Trip


class DjangoFilterCustom(DjangoFilterBackend):

    def filter_queryset(self, request, queryset, view):
        start_time = request.query_params.get("start_time", None)
        end_time = request.query_params.get("end_time", None)
        queryset = super(DjangoFilterCustom, self).filter_queryset(request, queryset, view)

        try:
            if start_time:
                date = datetime.datetime.strptime(start_time, "%Y-%m-%d")
                querysets = Trip.objects.filter(start_time__gte=date)

                return querysets

            if end_time:
                date = datetime.datetime.strptime(end_time, "%Y-%m-%d")
                querysets = Trip.objects.filter(start_time__lte=date)

                return querysets
        except:
            raise rest_framework.exceptions.ValidationError(
                {"start_time": "Lỗi định dạng ngày tháng năm."},
                {"end_time": "Lỗi định dạng ngày tháng năm."})

        return queryset

    def get_filterset_kwargs(self, request, queryset, view):
        data = request.query_params.copy()
        data.pop("start_time", None)
        data.pop("end_time", None)

        return {
            'data': data,
            'queryset': queryset,
            'request': request,
        }
