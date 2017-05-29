
Simple Taunt Announce
=====================

Copyright 2011-2016 BeathsCurse (Saphod - Draenor EU)


Introduction
------------

Simple Taunt Announce (STA) is a World of Warcraft addon that aims to be a
relatively simple and efficient, yet flexible taunt announcer. The main use
of such an addon is to help coordinate taunt swapping in raids (though it
also works well for blaming the pug DK dps who thinks Death Grip is part of
his rotation).

STA will announce failed taunts (targets who are immune), and for multi-target
taunts it will announce one target only (the first one to appear in the combat
log).

If you need more flexibility there are other options, like for instance
[Raeli's Spell Announcer][RSA] which can announce all kinds of things.

[RSA]: http://www.curse.com/addons/wow/rsa


Settings
--------

STA stores settings for how to announce taunts based on your grouping status.
So you can have separate settings for when you are solo, in an instance group,
party, or raid.

For each of these four statuses, STA can announce your own taunts, and those
of other people/pets in your party/raid.

Announcing is based on modes, which decide what channel the announcement goes
to. They can be: off, self, say, instance, party, and raid.

The default settings are:

    status       own    other
    -------------------------
    solo        self      N/A
    instance    self     self
    party       self     self
    raid         say     self

So, when you are playing solo, you will get your own taunts announced to
yourself, and not see others. When in an instance group or party, your own
taunts and other peoples taunts will be announced to yourself. When in a
raid, your own taunts will be announced in say, and you will see other
peoples taunts announced to yourself.

Own covers taunts made by you or your pet, other covers taunts made by any
player or pet in your party/raid.

Instance groups are groups/raids created by the instance finder (LFD/LFR/etc.)
Announcing is turned off in battlegrounds and arenas.

STA can optionally play a sound when announcing. In the configuration panel
you can select one of the default sounds, or you can add your own custom sound
files to Interface/AddOns/SimpleTauntAnnounce with one of these names:
sound1.mp3, sound2.mp3, sound1.ogg, sound2.ogg.


Slash Commands
--------------

You can enable and disable announcing with

    /sta on
    /sta off

You can use

    /sta <status>

to see what the modes are for that status. And

    /sta <status> [own [other]]

to set the mode for own and other taunts respectively.

For switching modes in macros, a special compact syntax is supported; an
exclamation mark followed by eight characters, two (own and other) for each
of the four statuses. Each character can be: o = off, m = self, s = say,
i = instance, p = party, r = raid. If a character is not one of these, the
corresponding mode is not changed.

Here are a few examples:

    /sta party         - print current party modes
    /sta solo self     - when solo, own taunts to yourself
    /sta raid say self - when raid, own to say, others to self
    /sta !mommmmsm     - set default modes
