# Generated by Django 3.2.5 on 2021-12-25 08:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0013_auto_20210823_2158'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ticketdetail',
            name='seat_position',
            field=models.IntegerField(),
        ),
    ]
