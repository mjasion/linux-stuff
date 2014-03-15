##!/bin/sh
# Simple backup script

# Pelne sciezki katalogow lub plikow ktore maja byc zachowane.
# To sa tylko przyklady. Prosze zwrocic uwage na cudzyslowia.
dirs="
/home
/etc
/var/log"

# Utworz nazwe pliku z backupem:
backup="`hostname`_`date +%Y-%m-%d_%H:%M`.tgz"
backup_folder="/var/backup"
# Upewnij się czy katalog dla backupów istnieje:
mkdir $backup_folder

# Upewnij sie ze dostep do backupow ma tylko root 
chown -R root:wheel /var/backup
chmod -R 755 /var/backup

# Usun stare backupy (lub ewentualnie plik o takiej samej nazwie)
find . -name 'mjasion*' -mtime +3 -delete

# 'tarujemy'
tar -c --file $backup_folder/$backup -p -P --gzip -v $dirs