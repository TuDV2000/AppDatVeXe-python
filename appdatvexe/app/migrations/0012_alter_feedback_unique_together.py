# Generated by Django 3.2.5 on 2021-08-23 11:01

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0011_alter_line_unique_together'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='feedback',
            unique_together={('user', 'trip')},
        ),
    ]
