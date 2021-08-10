# Generated by Django 3.2.5 on 2021-08-09 11:27

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0006_auto_20210808_1724'),
    ]

    operations = [
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('trip', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='feedback_trip', to='app.trip')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='feedback_user', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
