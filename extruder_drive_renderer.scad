/*
extruder_drive_renderer.scad is the rendering portion of the extruder drive used on Phidias products
Copyright (C) 2015 Gerald Anzalone

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

include<extruder_drive.scad>

render_part(1);

// not all drive gears are created equally, set drive gear dimensions here:
d_gear = 12.7; // diameter of the drive gear - original mk7 drive gear = 12.7
d_hob = 11.2; // diameter of the hobbed portion of the drive gear - original mk7 drive gear = 11.3

//d_gear = 12; // diameter of the drive gear - Chinese mk7 drive gear
//d_hob = 10.65; // diameter of the hobbed portion of the drive gear - Chinese mk7 drive gear

// following set the dimensions for a given filament [d_retainer, h_retainer, d_sheath, d_filament, offset_filament]
filament300 = [d_M6_nut, h_M6_nut, 6.55, 3.4, 5.925];
filament175 = [d_M4_nut, h_M4_nut, 4.5, 2.1, d_hob - 5.5]; // original mk7 drive gear offset derived by trial and error
filament = filament175; // set to one of the two, above

d_retainer = filament[0];
h_retainer = filament[1];
d_sheath = filament[2];
d_filament = filament[3];
offset_filament = filament[4];
tweak_path = 0.7; // allows for adjusting the distance between the filament path and drive gear 0.7 works great for original mk7 w/ 12.5mm diameter

// Bowden sheath quick release fitting dims
d_quickrelease_threads = 6.4; // M6 threads, but this gives best fit
l_quickrelease_threads = 5; // length of threads on quick release
pitch_quickrelease_threads = 1;

module render_part(part_to_render) {
	if (part_to_render == 1) {
		drive_body(
			d_retainer = d_retainer,
			h_retainer = h_retainer,
			d_sheath = d_sheath,
			d_filament = d_filament,
			t_feet = t_feet,
			t_base = t_base,
			offset_filament = offset_filament,
			quick_release = true);
	}

	if (part_to_render == 2) extruder_idler_608z();

	if (part_to_render == 3) support_strut();

	if (part_to_render == 4) axle_8mm();

	if (part_to_render == 5) {
		translate([0,-20,0])
			rotate([0,0,270])
				drive_body(
					d_retainer = d_retainer,
					h_retainer = h_retainer,
					d_sheath = d_sheath,
					d_filament = d_filament,
					t_feet = t_feet,
					t_base = t_base,
					offset_filament = offset_filament,
					quick_release = true);

		translate([10, 10 + t_feet, 0]) rotate([0, 0, 90]) extruder_idler_608z();
		translate([10, 26 + t_feet, 0]) support_strut();
		translate([-16, 9 + t_feet, 0]) axle_8mm();
	}

	if (part_to_render == 99) sandbox();
}

module sandbox() {
	for (i = [0:5])
//		for (j = [-1, 1])
	rotate([0, 0, i * 60])
		translate([21, 0, 0])
			axle_8mm();

		axle_8mm();
}
