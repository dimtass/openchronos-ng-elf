/* This file is autogenerated by tools/make_modinit.py, do not edit! */


extern void mod_clock_init();
extern void mod_stopwatch_init();
extern void mod_alarm_init();
extern void mod_temperature_init();
extern void mod_battery_init();
extern void mod_reset_init();

void mod_init(void)
{
    mod_clock_init();
    mod_stopwatch_init();
    mod_alarm_init();
    mod_temperature_init();
    mod_battery_init();
    mod_reset_init();
}
