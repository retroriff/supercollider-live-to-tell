// Madonna - Live To Tell

("setup/Setup.scd").loadRelative;
("SynthDefs.scd").loadRelative;

p.clock.tempo = 120/60;

l = Buffer.read(s, "samples/Live To Tell.aiff".resolveRelative);
m = Buffer.read(s, ("samples/Kick.aiff").resolveRelative);
c = Buffer.read(s, ("samples/Ch0.wav").resolveRelative);
k = Buffer.read(s, ("samples/K1.wav").resolveRelative);

(
~live = Pbind(
    \instrument, \vplay,
    \buf, l,
    \dur, Pseq([1, 0.5], inf).trace,
    \amp, Pseq([0.8, 0.7, 0.6, 0.4],inf),
    \sus, Pseq([1, 1, 1, 0.5],inf),
	\pos, Pwrand([0, Pwhite(0.1, 0.9, 1)], [10, 1].normalizeSum, inf)
));
~live.fadeTime = 0;
~live.play.quant_(6, -1);
~live.stop;

(
~ch = Pbind(
    \instrument, \bplay,
	\buf, c,
	\dur, Pseq([0.5, Pwrand([1, Pseq([0.25, 0.75]), Pseq([0.25/8], 32)], [16, 5, 1].normalizeSum, inf)]),
	\amp, Pwhite(0.03, 0.08, inf),
	\rate, Pseq([1, 1.1], inf)
));
~ch.fadeTime = 0
~ch.play.quant_(6, -1);
~ch.stop;

(
~k = Pbind(
    \instrument, \bplay,
	\buf, Pseq([d["k"][1]], inf),
	\dur, 1,
    \amp, 0.15,
));
~k.play.quant_(6, -1);
~k.stop;

(
~bass = Pbind(
    \instrument, \ring1,
	\dur, Pseq([0.5, 0.5, 0.5, 0.5, 1], inf),
	\f, 45,
    \amp, 0.15,
));
~bass.play.quant_(4, -1);
~bass.stop;

(
~ko = Pbind(
    \instrument, \bplay,
    \buf, m,
    \dur, Pseq([1, 0.5], inf),
    \amp, Pseq([0.8, 0.7, 0.6, 0.4]*1.2,inf),
    \sus, Pseq([1, 1, 1, 0.5],inf),
));
~ko.fadeTime = 20;
~ko.play.quant_(6, -1);
~ko.stop;

(
~tb303 = Pbind(
    \instrument, \tb303,
	\dur, Pseq([1], inf),
    \freq, 45,
    \amp, 1,
));
~tb303.play.quant_(6, -1);
~tb303.stop
;