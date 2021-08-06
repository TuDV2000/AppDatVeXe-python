# Generated by Django 3.2.5 on 2021-07-30 15:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='ticket',
            name='name',
        ),
        migrations.RemoveField(
            model_name='vehicle',
            name='name',
        ),
        migrations.AlterField(
            model_name='user',
            name='avatar',
            field=models.ImageField(null=True, upload_to='images/%Y/%m'),
        ),
        migrations.AlterField(
            model_name='vehicle',
            name='license_plate',
            field=models.CharField(max_length=50, unique=True),
        ),
        migrations.AlterField(
            model_name='vehicletype',
            name='name_type',
            field=models.CharField(max_length=200, unique=True),
        ),
    ]
