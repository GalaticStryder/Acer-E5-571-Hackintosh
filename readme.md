A place for patches that allow booting OSX in the Acer E5-571-376T. Fow now, this repo is under construction, it'll take time to get something decent as I'm newbie on it and Broadwell is a pain.

Proccess to extract DSTD from GNU/Linux:

            mkdir ascpi-tables
            sudo cp -R /sys/firmware/acpi/tables ascpi-tables
            sudo chmod -R ugo+rw ascpi-tables
            sudo chown -R galatic ascpi-tables

Doing this way we avoid permission problems by making it read/write able by anyone. Also, this changes from root to my user the ownership, just in case.
