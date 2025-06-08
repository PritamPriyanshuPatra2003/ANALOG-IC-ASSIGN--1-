v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -340 -0 -340 20 {lab=vnmic}
N -340 -0 -270 0 {lab=vnmic}
N -340 80 -340 110 {lab=GND}
N 30 100 30 130 {lab=GND}
N 30 -20 70 -20 {lab=vcm}
N 30 -20 30 40 {lab=vcm}
N 10 0 50 -0 {lab=virt}
N 50 -0 50 10 {lab=virt}
N 50 10 70 10 {lab=virt}
N 120 30 120 80 {lab=GND}
N 110 -80 180 -80 {lab=vout}
N 180 -80 180 -0 {lab=vout}
N 110 -140 180 -140 {lab=vout}
N 180 -140 180 -80 {lab=vout}
N 170 -0 180 -0 {lab=vout}
N 250 40 250 70 {lab=GND}
N 250 -50 250 -20 {lab=vout}
N 180 -50 250 -50 {lab=vout}
N 20 -140 50 -140 {lab=virt}
N 20 -140 20 -0 {lab=virt}
N 20 -80 50 -80 {lab=virt}
N -210 -0 -170 -0 {lab=vin1}
N -110 -0 -50 -0 {lab=vin2}
C {res.sym} -20 0 3 0 {name=R1
value=4.7k
footprint=1206
device=resistor
m=1}
C {capa.sym} 250 10 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {vsource.sym} 30 70 0 0 {name=V1 value=1.5 savecurrent=false}
C {vsource.sym} -340 50 0 0 {name=V2 value="0 AC 1" savecurrent=false}
C {res.sym} -240 0 3 0 {name=R2
value=380

footprint=1206
device=resistor
m=1}
C {capa.sym} 80 -140 3 0 {name=C2
m=1
value=27p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -340 110 0 0 {name=l1 lab=GND}
C {res.sym} 80 -80 3 0 {name=R3
value=300k
footprint=1206
device=resistor
m=1}
C {highpass_1.sym} 110 130 0 0 {name=x1}
C {gnd.sym} 30 130 0 0 {name=l2 lab=GND}
C {gnd.sym} 120 80 0 0 {name=l3 lab=GND}
C {gnd.sym} 250 70 0 0 {name=l4 lab=GND}
C {lab_pin.sym} 180 0 3 0 {name=p1 sig_type=std_logic lab=vout}
C {lab_pin.sym} 30 30 0 0 {name=p2 sig_type=std_logic lab=vcm}
C {lab_pin.sym} -80 0 3 0 {name=p3 sig_type=std_logic lab=vin2}
C {lab_pin.sym} -190 0 3 0 {name=p4 sig_type=std_logic lab=vin1
}
C {simulator_commands_shown.sym} -1100 -370 0 0 {name=COMMANDS
simulator=ngspice
only_toplevel=false 
value="
.control
	op
	save all
	set appendfile
	trans 1n 2u
	ac dec 100 0.1 100k
plot v(vout)
set units=degrees
* Plot gain and phase
plot db(v(vout))
plot phase v(vout)

* Measure maximum gain
	MEAS AC max_gain MAX vdb(vout) FROM=0.1 TO=10e6

* Find -3dB point (from max gain)
	LET vm3db = max_gain - 3
  	MEAS AC fzero WHEN vdb(vout) = vm3db RISE=1
  	MEAS AC fpole WHEN vdb(vout) = vm3db FALL=1
	MEAS AC fgain WHEN vdb(vout) = max_gain 
	
 
*for phase
	LET phase_deg = cph(vout)
	MEAS  AC phase_initial FIND phase_deg at=fzero
	MEAS  AC phase_initial FIND phase_deg at=fpole
	MEAS  AC phase_gain FIND phase_deg at=fgain
	
* Write raw file
write micopamp.raw
.endc
"}
C {capa.sym} -140 0 3 0 {name=C3
m=1
value=4.7u
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} -310 0 1 0 {name=p5 sig_type=std_logic lab=vnmic}
C {lab_pin.sym} 20 -50 0 0 {name=p6 sig_type=std_logic lab=virt}
