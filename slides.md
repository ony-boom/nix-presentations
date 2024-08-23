---
marp: true
theme: default
class: invert
---
<!-- footer: ❄️ -->

<style>
    @import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap');

    section {
        font-size: 20px;
        font-family: "Open Sans", sans-serif;
    }
</style>

# Nix

A cross-platform **package manager** for Unix-like systems, invented in 2003 by Eelco Dolstra. _[Wikipedia](https://en.wikipedia.org/wiki/Nix_(package_manager)s)_

Nix is a tool that takes a unique approach to package management and system configuration. Learn how to make **reproducible**, **declarative** and **reliable systems**. _[Official site](https://nixos.org/)_

---

## The nix ecosystem (a rabbit hole)

but, nix is also:
- an os _(more on this later)_
- a programming language
...

![w:70% right bg](./images/nix-ecosystem.png)

---
<!-- footer: ❄️❄️ -->

# So, why Nix ?

My main reasons:

1. Declarative and reproducible
2. Multiple package versions
3. Easy Rollback
4. Seamless integration with other tools
5. Nix packages repository is huge ([This huge](https://repology.org/repositories/graphs))



> More reasons [here](https://nixos.org/guides/nix-pills/01-why-you-should-give-it-a-try)!

---

## 1. **Declarative** and **reproducible**.

This is the most obvious benefit, as it is the whole motivation behind Nix. 
Two people building the same package will always get the same output, if you’re careful enough with pinning the versions of inputs in place.
And even if some input is different, it will be very clear since the store path will change.

![bg right w:100%](./images/reproducible.png)

---

## 2. **Multiple versions of any package** can be installed simultaneously

Every package is installed under its own prefix, so there are no collisions (unless a given package depends on multiple versions of another package, which is a rare occasion and is usually easy enough to handle).
This can be really handy during development – no more `nvm`, `volta`, ...

![bg right w:100%](./images/multi.png)


---
<!-- footer: ❄️❄️❄️ -->

# How to Nix ?

Yes, demo time! 🎉. We're gonna see how to use:

1. nix as package manager _(project level)_
    - To install packages, and make a reproducible dev environment

2. nix/nixos to configure your system in a rebroducible way. _(system level, so, as a server)_

We're gonna use this presentation as demo

![bg right](./images/show.gif)

---

## Installing nix:

- [Official way](https://nixos.org/download/)
- [An more clean way](https://github.com/DeterminateSystems/nix-installer)

---

<!-- footer: ❄️❄️❄️❄️ -->

<style scoped>
    section {
        text-align: center;
    }    
</style>

# END OF THE SLIDES

Time for real example

