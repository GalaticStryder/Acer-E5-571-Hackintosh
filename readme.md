Mac OS X on the Acer Aspire E5-571-376T
==========================
![Acer Aspire E5-571-376T](https://raw.githubusercontent.com/GalaticStryder/Acer-E5-571-Hackintosh/master/header.png)

A place/guide for patches that allow booting OSX in the Acer E5-571-376T. Fow now, this repo is under construction (maybe forever), it'll take some time to get something decent as I'm newbie on it (GNU/Linux guy).

All the processes are generically the same for a hackintosh laptop build (Intel), but DSDT/SSDT patching and some more specific things like kexts and stuff should be device/board particular.

Notice that I'm not gonna teach someone "how to", there are many places on forums to get every guide you need. If you don't know what are the steps for your model, please checkout tonymac's website/forum and **read** the guides and threads for El Capitan laptop support.

As for Acer laptops, notice that this is one of a thousand other models, any minimal difference might get you a laptop that doesn't boot or even brick it depending on what mess you gonna be doing. That's why I encourage you to **not** follow this guide as a reference for now, even with the same model. If you want to mess around as well... go for it then, I advised.

Environment
-------------------------

I've got two machines to do this job:

- A **desktop computer** running Mac OS X as guest in VirtualBox being hosted by Arch Linux (Linux Kernel 4.3)

That’s the servo for downloading the **official** installer and for the clovered USB creation.

Note: To get a decente performance on the guest O.S. you must set 256MB of VRAM for your Mac V.M. trough the .vdi file and use **beamoff** app on startup. Resolution fix can easily be found at a Google search.

- Target **Acer E5-571-376T** laptop running Ubuntu 15.10 in UEFI mode (GPT table) and Mac OS X 10.11.2

I totally recommend dual-booting with a Linux distribution, even if you don’t like it, truth is that it won’t let you down if you need the laptop as a daily driver. Not only that, if you patch something wrong and it breaks booting, there’s no worry, boot Ubuntu and copy back the previous configuration to get Mac up and running again.

Usually /dev/sda1 is the EFI partition, so:

	sudo mkdir /mnt/efi
	sudo mount /dev/sda1 /mnt/efi

Change what you need and umount.

	sudo umount /dev/sda1

It’s worth to mention that my EFI partition wasn’t created by OS X, it has been around since I installed Ubuntu 15.10 some weeks ago, no problems at all once Clover won’t format it anyway.

Hardware
-------------------------

You'll find all hardware related stuff in **information** folder. The basic hardware information about the main laptop components are the following:

- Intel Core i3-5005U
- Intel Graphics HD5500
- [Intel 9 Series Chipset](http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/9-series-chipset-pch-datasheet.pdf)
 - Wildcat Point-LP SATA Controller [AHCI Mode]
 - Wildcat Point-LP High Definition Audio Controller
 - Wildcat Point-LP USB xHCI Controller
 - Wildcat Point-LP LPC Controller
 - Wildcat Point-LP SMBus Controller
 - Wildcat Point-LP Thermal Management Controller
 - More...
- Atheros AR3012 Bluetooth
- Realtek RTL8111/8168/8411 Ethernet Controller
- QCA9565 / AR9565 Wireless Network Adapter

**Screenshot:**

![INXI Hardware](https://raw.githubusercontent.com/GalaticStryder/Acer-E5-571-Hackintosh/master/information/inxi.png)

Instructions
-------------------------

Before going anywhere else, please, check you laptop model twice.
Confirmed it is the same as stated in the repository or close a one? Then, you can step forward.

Clone this repository into a development folder if you don't have one.

	mkdir Development
	cd Development
	git clone https://github.com/GalaticStryder/Acer-E5-571-Hackintosh

**Warning:** Use the clean.sh script in this folder to start doing your own hackintosh from "scratch" in case it's not the **same** E5-571-**346T**, and don't forget to check **all** specs to see what matches and what doesn't, i.e.: CPU must be a Broadwell one, this spec is our north. **Generating you own DSDT is recommended.**

	./clean.sh

Proccess to extract DSTD from GNU/Linux:

	cd dsdt
	mkdir original
	sudo cp -R /sys/firmware/acpi/tables original
	sudo chmod -R ugo+rw original
	sudo chown -R galatic original

Doing this way we avoid permission problems by making it read/write able by anyone. Also, this changes from root to my user the ownership, just in case.

To rename the files I've just adapted RehabMan's script to my **original** folder.

	./aml-rename.sh

Now it should contain one DSDT and a nine SSDTs as **.aml** files, as mentioned they were all extracted from a GNU/Linux distribution (Ubuntu 15.10) with Linux kernel 4.1.

To patch your DSDT (when I say DSDT means both DSDTs/SSDTs - that's why folder name is "dsdt" as well) you will need to use MaciASL and iasl tools. Copy iasl binary from the folder **tools** to /usr/bin for system-wide ability.

	cd extras
	sudo cp iasl /usr/bin/iasl

Cortesy of RehabMan at [BitBucket](https://bitbucket.org/RehabMan/acpica/downloads).

Proceed to **dsl** generation after the previous step.

	cd dsdt
	mkdir dsl
	cd original

First create a refs.txt with the following content:

	External (_SB_.PCI0.PEG0.PEGP.SGPO, MethodObj, 2)
	External (_SB_.PCI0.LPCB.H_EC.ECWT, MethodObj, 2)
	External (_SB_.PCI0.LPCB.H_EC.ECRD, MethodObj, 1)

using your prefered text edior, I use vim.

	vim refs.txt

Then run iasl and move the files to the previously created dsl folder:

	iasl -da -dl -fe refs.txt *.aml
	mv *.dsl ../dsl/

Don't get confused with dsl folder and extension, ok?

After that you're aheading that neck to DSDT patching/fixing on **MaciASL app**. As for this laptop I added the following repos on it:

|      Name     |   URL Link    |
| ------------- | ------------- |
| Pjalm     | http://pjalm.com/repos/intel9/  |
| RehabMan  | http://raw.github.com/RehabMan/Laptop-DSDT-Patch/master |

The stock ones have a patch that we need, only one though so don't delete them.

I'm following Asus ZenBook (Broadwell as well) thread at tonymac for some of these steps cause as I said, close specs close settings, this UX303LA has a close setup with a few extras we don't need.

[Check the thread there.](http://www.tonymacx86.com/el-capitan-laptop-guides/172279-guide-asus-zenbook-ux303la-broadwell-edition.html)

[Another thread I'm following for this project is RehabMan's one.](http://www.tonymacx86.com/el-capitan-laptop-support/152573-guide-patching-laptop-dsdt-ssdts.html)

Following them we'll use the following patches for **DSDT.dsl.**

**RehabMan's:**

- Remove _DSM methods
- Audio Layout 12
- Fix _WAK Arg0 v2
- HPET Fix
- IRQ Fix
- RTC Fix
- Fix PNOT/PPNT
- Add IMEI
- Fix ADGB Error
- Brightness fix Haswell
- Rename GFX0 to IGPU
- Rename B0D3 to HDAU

**Pjalm's:**

- Generic Fixes
- LPC
- SMBus

Following them we'll use the following patches for **SSDTx.dsl.**

Note: Every SSDT is related to one or more components, you can get a clue at left panel name when opening it in MaciASL.

I needed to patch 4/9 or 5/9 SSDTs, some of them compile just fine without any patch needed, but...

- Generic Fixes (Pjalm)
- DTGP (SourceForge)
- Rename GFX0 to IGPU (Rehab)
- Rename B0D3 to HDAU (Rahab)
- Remove _PSS placeholders (Rehab)

**Other compiling issues:**

[Operator has no effect](https://github.com/GalaticStryder/Acer-E5-571-Hackintosh/commit/5c46b2ef43d6cd73f862d6c0eb58bea3c6d8d637)

[Audio 12](https://github.com/GalaticStryder/Acer-E5-571-Hackintosh/commit/c626185870a80038bf09026bbbc531e1f45d1736)
From [Machanical](http://www.tonymacx86.com/members/machanical/)

Many errors can be fault of **external declarations**, to sort that out just **cut** the three main external lines that have "1 arguments" or "2 arguments" comment to the bottom of the other external ones with one line space optionally.
From [Machanical](http://www.tonymacx86.com/members/machanical/)

That's a click compile and adjust job. After the solving all errors in all DSDT you've got to save as **.aml** back again, all of them. Put the saved ones (aml) in the compiled folder one by one.

After that let's get the real **Clover** setup...

Credits
-------------------------

- RehabMan
- Machanical

I'll add as this project goes on...

