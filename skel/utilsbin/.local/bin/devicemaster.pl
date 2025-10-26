#!/usr/bin/env perl

use strict;
use warnings;

use Cwd qw(abs_path);

# use USB::LibUSB;

sub read_sys_file {
	my ($filepath) = @_;

	open (my $fh, '<', $filepath) or return "Error opening file $filepath.";

	my $value = <$fh>;
	close $fh;

	chomp $value if defined $value;
	return $value;
}

sub get_command_output {
	my ($cmd) = @_;

	my $output = `$cmd`;

	chomp $output if defined $output;
	return $output;
}

sub print_p_state_info {
=begin comment

	Using Intel P State kernel driver
	https://docs.kernel.org/admin-guide/pm/cpufreq.html
	https://docs.kernel.org/admin-guide/pm/intel_pstate.html

=end comment

=cut

	my $status_file                                                          =     "/sys/devices/system/cpu/intel_pstate/status";
	my $no_turbo_file                                                        =     "/sys/devices/system/cpu/intel_pstate/no_turbo";
	my $hwp_dynamic_boost_file                                               =     "/sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost";
	my $max_perf_pct_file                                                    =     "/sys/devices/system/cpu/intel_pstate/max_perf_pct";
	my $min_perf_pct_file                                                    =     "/sys/devices/system/cpu/intel_pstate/min_perf_pct";
	my $core_dir_prefix                                                      =     "/sys/devices/system/cpu/cpufreq/policy";
	my $core_dir_glob                                                        =     "$core_dir_prefix*/";
	my $core_dir_regex                                                       =     qr/policy(\d+)\/?$/;
	my $core_scaling_governor_postfix                                        =     "scaling_governor";
	my $core_scaling_available_governors_postfix                             =     "scaling_available_governors";
	my $core_energy_performance_preference_postfix                           =     "energy_performance_preference";
	my $core_energy_performance_available_preferences_postfix                =     "energy_performance_available_preferences";
	my $core_scaling_min_freq_postfix                                        =     "scaling_min_freq";
	my $core_scaling_max_freq_postfix                                        =     "scaling_max_freq";
	my $core_cpuinfo_min_freq_postfix                                        =     "cpuinfo_min_freq";
	my $core_cpuinfo_max_freq_postfix                                        =     "cpuinfo_max_freq";
	my $status                                                               =     read_sys_file $status_file;
	my $no_turbo                                                             =     read_sys_file $no_turbo_file;
	my $hwp_dynamic_boost                                                    =     read_sys_file $hwp_dynamic_boost_file;
	my $max_perf_pct                                                         =     read_sys_file $max_perf_pct_file;
	my $min_perf_pct                                                         =     read_sys_file $min_perf_pct_file;

	print "P State Info\n";
	print "\tstatus: $status\n";
	print "\tno_turbo: $no_turbo\n";
	print "\thwp_dynamic_boost: $hwp_dynamic_boost\n";
	print "\tmax_perf_pct: $max_perf_pct\n";
	print "\tmin_perf_pct: $min_perf_pct\n";

	foreach my $core_dir (glob $core_dir_glob) {
		if ($core_dir =~ $core_dir_regex) {
			my $core = $1;

			my $scaling_governor = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_scaling_governor_postfix
			;

			my $energy_performance_preference = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_energy_performance_preference_postfix
			;

			my $scaling_available_governors = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_scaling_available_governors_postfix
			;

			my $energy_performance_available_preferences = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_energy_performance_available_preferences_postfix
			;

			$energy_performance_available_preferences =~ s/\s+$//;

			my $energy_performance_preference_output =
				$energy_performance_available_preferences =~ s/(?<!\S)$energy_performance_preference(?!\S)/$&*/r
			;

			my $scaling_governor_output =
				$scaling_available_governors =~ s/(?<!\S)$scaling_governor(?!\S)/$&*/r
			;

			my $scaling_min_freq = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_scaling_min_freq_postfix
			;

			my $scaling_max_freq = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_scaling_max_freq_postfix
			;

			my $cpuinfo_min_freq = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_cpuinfo_min_freq_postfix
			;

			my $cpuinfo_max_freq = read_sys_file
				$core_dir_prefix .
				$core .
				"/" .
				$core_cpuinfo_max_freq_postfix
			;

			printf "core %2d ", $core;
			print "[scaling governor: $scaling_governor_output]" .
				" [energy performance preference: $energy_performance_preference_output]\n"
			;
			print "\t[scaling min freq: ${scaling_min_freq}khz (limit: ${cpuinfo_min_freq}khz)]" .
				" [scaling max freq: ${scaling_max_freq}khz (limit: ${cpuinfo_max_freq}khz)]\n"
			;
		}
	}
}

sub print_g16_info {
=begin comment

	Using Alienware WMI kernel driver
	https://docs.kernel.org/wmi/devices/alienware-wmi.html
	https://docs.kernel.org/admin-guide/laptops/alienware-wmi.html

=end comment

=cut
	my $profile_path = ''; my $hwmon_path = ''; {
		my $profile_path_prefix   =   "/sys/class/platform-profile/platform-profile-";
		my $profile_path_glob     =   "$profile_path_prefix*/";
		my $profile_name          =   "alienware-wmi";

		for my $pr_path (glob $profile_path_glob) {
			my $pr_name_path = "$pr_path/name";

			if (-f $pr_name_path) {
				my $name = read_sys_file $pr_name_path;

				if ($profile_name eq $name) {
					$profile_path = $pr_path;
					last;
				}
			}
		}

		my $hwmon_path_prefix   =   "/sys/class/hwmon/hwmon*";
		my $hwmon_path_glob     =   "$hwmon_path_prefix*/";
		my $hwmon_name          =   "alienware_wmi";

		for my $hw_path (glob $hwmon_path_glob) {
			my $hw_name_path = "$hw_path/name";
			if (-f $hw_name_path) {
				my $name = read_sys_file $hw_name_path;
				if ($hwmon_name eq $name) {
					$hwmon_path = $hw_path;
					last;
				}
			}
		}
	}

	if ('' ne $profile_path) {
		my $profile_file           =   $profile_path . '/profile';
		my $profile_choices_file   =   $profile_path . '/choices';
		my $profile                =   read_sys_file $profile_file;
		my $profile_choices        =   read_sys_file $profile_choices_file;
		my $profile_output         =   $profile_choices =~ s/(?<!\S)$profile(?!\S)/$&*/r;

		print "Current Platform Profile: [$profile_output]\n";
	}

	if ('' ne $hwmon_path) {
		my $device_label_glob           =   "$hwmon_path/fan*_label";
		my $device_label_regex          =   qr/fan(\d+)_label/;
		my $device_prefix               =   "$hwmon_path/fan";
		my $device_label_postfix        =   "_label";
		my $device_boost_postfix        =   "_boost";
		my $device_input_postfix        =   "_input";
		my $device_min_postfix          =   "_min";
		my $device_max_postfix          =   "_max";
		my $device_temp_prefix          =   "$hwmon_path/temp";
		my $device_temp_input_postfix   =   "_input";
		my $device_temp_label_postfix   =   "_label";

		for my $device_label_path (glob $device_label_glob) {
			my ($device_id)         =   $device_label_path =~ $device_label_regex;
			my $device_label        =   read_sys_file $device_prefix . $device_id . $device_label_postfix;
			my $device_boost        =   read_sys_file $device_prefix . $device_id . $device_boost_postfix;
			my $device_input        =   read_sys_file $device_prefix . $device_id . $device_input_postfix;
			my $device_min          =   read_sys_file $device_prefix . $device_id . $device_min_postfix;
			my $device_max          =   read_sys_file $device_prefix . $device_id . $device_max_postfix;
			my $device_temp_label   =   read_sys_file $device_temp_prefix . $device_id . $device_temp_label_postfix;
			my $device_temp_input   =   read_sys_file $device_temp_prefix . $device_id . $device_temp_input_postfix;

			print "Found fan with id $device_id\n";
			print "\tlabel: $device_label\n";
			print "\tboost: $device_boost\n";
			print "\tinput: $device_input\n";
			print "\tmin: $device_min\n";
			print "\tmax: $device_max\n";
			print "\ttemp_label: $device_temp_label\n";
			print "\ttemp_input: $device_temp_input\n";
		}
	}
}

# use constant {
# 	# Use the actual hex values required by your device
# 	PREAMBLE => 0x03,
# 	SET_DIM  => 0x26,
# };
#
# sub send_set_dim {
# 	my ($device_handle, $dim, $zone_count, @zones) = @_;
#
# 	my @packet = (
# 		PREAMBLE,
# 		SET_DIM,
# 		$dim,
# 		($zone_count >> 8) & 0xFF,
# 		$zone_count & 0xFF,
# 		@zones,
# 	);
#
# 	my $packed_data = pack('C*', @packet);
#
# 	# This is the correct method name from your file
# 	my $bytes_sent = $device_handle->control_transfer_write(
# 		0x21,          # bmRequestType
# 		0x09,          # bRequest
# 		0x0202,        # wValue
# 		0,             # wIndex
# 		$packed_data,  # data
# 		0           # timeout
# 	);
#
# 	print "bytes_sent: $bytes_sent\n";
#
# 	# The return value from this function is the number of bytes written,
# 	# so we compare against the original length.
# 	if ($bytes_sent != length($packed_data)) {
# 		warn "Error sending data: transfer incomplete. Sent $bytes_sent bytes.";
# 		return 0;
# 	}
#
# 	return 1;
# }
#
# sub keyboard_backlight {
# 	my $ctx = USB::LibUSB->init ();
# 	unless ($ctx) {
# 		warn "failed to get libusb context";
# 		return;
# 	}
#
# 	my @devices = $ctx->get_device_list ();
#
# 	my $device_vid;
# 	my $device_pid;
#
# 	for my $device (@devices) {
# 		my $desc = $device->get_device_descriptor ();
# 		my $idVendor = $desc->{idVendor};
# 		my $idProduct = $desc->{idProduct};
#
# 		if (0x187c == $idVendor && (0x0550 == $idProduct || 0x0551 == $idProduct)) {
# 			$device_vid = $idVendor;
# 			$device_pid = $idProduct;
# 			last;
# 		}
# 	}
#
# 	if ($device_vid && $device_pid) {
# 		print "found keyboard backlight device with vid $device_vid and pid $device_pid\n";
#
# 		if (0) {
# 			my $device_handle = $ctx->open_device_with_vid_pid ($device_vid, $device_pid);
#
# 			unless ($device_handle) {
# 				warn "failed to get libusb device handle";
# 				return;
# 			}
#
# 			my $kernel_driver_was_detached = 0;
#
# 			if ($device_handle->kernel_driver_active(0)) {
# 				if ($device_handle->detach_kernel_driver(0) != 0) {
# 					die "Could not detach kernel driver!";
# 				}
# 			}
#
# 			if ($device_handle->claim_interface(0) != 0) {
# 				die "Could not claim interface 0!";
# 			}
#
# 			# device related stuff here...
# 			send_set_dim ($device_handle, 0, 1, 0);
#
# 			if ($device_handle->release_interface(0) != 0) {
# 				warn "Could not release interface 0!";
# 			}
#
# 			if ($kernel_driver_was_detached) {
# 				if ($device_handle->attach_kernel_driver(0) != 0) {
# 					warn "Could not re-attach kernel driver!";
# 				}
# 			}
# 		}
# 	}
# }

sub screen_backlight {
=begin comment

	https://www.kernel.org/doc/html/latest/gpu/backlight.html

=end comment

=cut

	my $backlight_dir_prefix                  =   "/sys/class/backlight/";
	my $backlight_dir_glob                    =   "$backlight_dir_prefix*/";
	my $backlight_dir_regex                   =   qr#\/([^/]+)\/?$#;
	my $backlight_brightness_postfix          =   "brightness";
	my $backlight_actual_brightness_postfix   =   "actual_brightness";
	my $backlight_max_brightness_postfix      =   "max_brightness";

	for my $backlight_dir (glob $backlight_dir_glob) {
		my ($backlight_name)              =   $backlight_dir =~ $backlight_dir_regex;
		my $backlight_brightness          =   read_sys_file $backlight_dir . $backlight_brightness_postfix;
		my $backlight_actual_brightness   =   read_sys_file $backlight_dir . $backlight_actual_brightness_postfix;
		my $backlight_max_brightness      =   read_sys_file $backlight_dir . $backlight_max_brightness_postfix;

		print "Found Backlight: $backlight_name\n";
		print "\tbrightness: $backlight_brightness\n";
		print "\tactual_brightness: $backlight_actual_brightness\n";
		print "\tmax_brightness: $backlight_max_brightness\n";
	}
}

sub print_gpu_infos {
	my $card_dir_prefix                   =     "/sys/class/drm/card";
	my $card_dir_glob                     =     "$card_dir_prefix*/";
	my $card_dir_regex                    =     qr/card(\d+)\/?$/;
	my $card_driver_name_regex            =     qr#\/([^/]+)\/?$#;
	my $intel_card_freq_min_postfix       =     "gt_min_freq_mhz";
	my $intel_card_freq_max_postfix       =     "gt_max_freq_mhz";
	my $intel_card_freq_boost_postfix     =     "gt_boost_freq_mhz";
	my $nvidia_card_pci_path_glob         =     "/proc/driver/nvidia/gpus/*";
	my $nvidia_card_pci_regex             =     qr#\/([^/]+)\/?$#;
	my $nvidia_card_pci_power_postfix     =     "power";

	for my $card_dir (glob $card_dir_glob) {
		if ($card_dir =~ $card_dir_regex) {
			my $card                         =   $1;
			my $card_driver_symlink          =   "$card_dir/device/driver";
			my $card_driver_path             =   abs_path ($card_driver_symlink);
			my ($card_driver_name)           =   $card_driver_path =~ $card_driver_name_regex;

			print "Found gpu with id $card\n";
			print "\tdriver: $card_driver_name\n";
			if ("i915" eq $card_driver_name) {
				my $card_freq_min              =   read_sys_file $card_dir . $intel_card_freq_min_postfix;
				my $card_freq_max              =   read_sys_file $card_dir . $intel_card_freq_max_postfix;
				my $card_freq_boost            =   read_sys_file $card_dir . $intel_card_freq_boost_postfix;
				my $intel_card_freq_RP_glob    =   "$card_dir/gt_RP*_freq_mhz";
				my $intel_card_freq_RP_regex   =   qr#\/([^/]+)\/?$#;

				print "\tmin freq: ${card_freq_min}\n";
				print "\tmax freq: ${card_freq_max}\n";
				print "\tboost freq: ${card_freq_boost}\n";

				for my $intel_card_RP_freq_file (glob $intel_card_freq_RP_glob) {
					my ($intel_card_RP_freq_name) = $intel_card_RP_freq_file =~ $intel_card_freq_RP_regex;
					$intel_card_RP_freq_name =~ s/^.*\/gt_(RP\w+)_freq_mhz$/$1/;
					my $intel_card_RP_freq = read_sys_file $intel_card_RP_freq_file;

					print "\t$intel_card_RP_freq_name: $intel_card_RP_freq\n"
				}
			}
			elsif ("nvidia" eq $card_driver_name) {
				for my $card_pci_dir (glob $nvidia_card_pci_path_glob) {
					my $card_power_state_path = "$card_dir/device/power_state";
					my $card_power_state = read_sys_file "$card_power_state_path";

					my ($card_pci) = $card_pci_dir =~ $nvidia_card_pci_regex;
					my $card_power_info_path = $card_pci_dir . '/' . $nvidia_card_pci_power_postfix;
					print "\tpci: $card_pci\n";
					print "\tpower state: $card_power_state\n";
					print "\tpower info:\n";

					open (my $fh, '<', $card_power_info_path) or return "Error opening file.";

					while (<$fh>) {
						chomp;
						my $line = $_;

						print "\t\t$line\n";
					}

					close $fh;
				}
			}
		}
	}
}

sub check_services {
	my $thermald_status              =   get_command_output "systemctl is-active thermald";
	my $nvidia_persistenced_status   =   get_command_output "systemctl is-active nvidia-persistenced";
	my $nvidia_powerd_status         =   get_command_output "systemctl is-active nvidia-powerd";
	my $scx_status                   =   get_command_output "systemctl is-active scx_loader";

	print "thermald status: $thermald_status\n";
	print "nvidia_persistenced status: $nvidia_persistenced_status\n";
	print "nvidia_powerd status: $nvidia_powerd_status\n";
	print "scx status: $scx_status\n";
}

sub print_device_name {
	print ((read_sys_file "/sys/class/dmi/id/product_name") . "\n");
}

print_device_name;
print_p_state_info;

print "\n" . '=' x 50 . "\n\n";

print_g16_info;

# print "\n" . '=' x 50 . "\n\n";
#
# keyboard_backlight;

print "\n" . '=' x 50 . "\n\n";

screen_backlight;

print "\n" . '=' x 50 . "\n\n";

check_services;

print "\n" . '=' x 50 . "\n\n";

print_gpu_infos;
