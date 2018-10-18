#pragma once
#include <time.h>
#include <math.h>
#include "spa.h"

static void Mext_epoch2date(double epoch, int* year, int* month, int* day) {
	time_t t = (int)epoch; 
	struct tm* t_s = gmtime(&t);
	*year = t_s->tm_year + 1900;
	*month = t_s->tm_mon + 1;
 	*day = t_s->tm_mday;
}


spa_data epoch2spa_data(const double epoch, const double latitude, const double longitude, const double elevation){
	spa_data spa;
	time_t t = (int)epoch; 
	struct tm* t_s = gmtime(&t);
	spa.year = t_s->tm_year + 1900;
	spa.month = t_s->tm_mon + 1;
	spa.day = t_s->tm_mday;
	spa.hour = t_s->tm_hour;
	spa.minute = t_s->tm_min;
	spa.second = t_s->tm_sec;
	spa.timezone = 0;
	spa.delta_ut1 = 0;
	spa.delta_t = 67;
	spa.longitude = longitude;
	spa.latitude = latitude;
	spa.elevation = elevation;
	spa.pressure = 1013 * exp(-elevation/7990);
	spa.temperature = 10; 
	spa.slope =0; 
	spa.azm_rotation = 0;
	spa.atmos_refract = 0.5667;
	spa.function = SPA_ZA;
	return spa;
};


static double Mext_epoch2azi(double epoch, double latitude, double longitude, double elevation) {
	spa_data spa;
	spa = epoch2spa_data(epoch, latitude, longitude, elevation); 
	spa_calculate(&spa);
	return spa.azimuth;
}

static double Mext_epoch2zenith(double epoch, double latitude, double longitude, double elevation) {
	spa_data spa;
	spa = epoch2spa_data(epoch, latitude, longitude, elevation);
	spa_calculate(&spa); 
	return spa.zenith;
}
