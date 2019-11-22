// Plays a file
(
SynthDef(\playbuf, {
    |amp=0.5, attack=0.01, buf=0, gate=1, out=0, release=0.05, rate=1, sustain=1, pan=0, pos=0|
    var sig, env;
    sig = Mix.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2));
    env = EnvGen.kr(Env.asr(attack, amp, release), gate, doneAction: Done.freeSelf);
    Out.ar(out, Pan2.ar(sig * env * amp, pan));
}).add;
);

// Roland TB 303
// https://sccode.org/1-4Wy
(
 SynthDef (\tb303, {
    |out=0, freq=440, wave=0, ctf=100, res=0.2, sus=0, dec=1.0, env=1000, gate=1, vol=0.2|
	var  filEnv, volEnv, waves;
	volEnv =  EnvGen .ar( Env .new([10e-10, 1, 1, 10e-10], [0.01, sus, dec],  'exp' ), gate, doneAction: Done.freeSelf);
	filEnv =  EnvGen .ar( Env .new([10e-10, 1, 10e-10], [0.01, dec],  'exp' ), gate, doneAction: Done.freeSelf);
	waves = [ Saw .ar(freq, volEnv),  Pulse .ar(freq, 0.5, volEnv)];
	Out .ar(out,  RLPF .ar(  Select .ar(wave, waves), ctf + (filEnv * env), res).dup * vol);
}).add;
)