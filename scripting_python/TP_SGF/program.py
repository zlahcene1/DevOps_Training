import sys
import os
import shutil
import ftplib as FTP
import socket
import time

_ftp = None

def lsDir(PATH):
    file = os.listdir(PATH)
    for f in file:
        print(f)
    print("\n")
    time.sleep(1)

def lsFile(PATH):
    file = os.listdir(PATH)
    for f in file:
        fpath = os.path.join(PATH, f)
        if os.path.isfile(fpath):
            print(f)
    print("\n")
    time.sleep(1)

def openDir(PATH):
    try:
        rep = input("quel repertoire? ")
        PATH = os.path.join(os.getcwd(), rep)
        os.chdir(PATH)
        return PATH
    except FileNotFoundError:
        print("Repertoire non existant")
    except PermissionError:
        print("Pas les droits.")


def renameDir(PATH):
    try:
        os.rename(input("Quel repo/fichier? "), input("QUel est son nouveau nom? "))
    except FileNotFoundError:
        print("Le nom n'existe pas")
    except OSError:
        print("Une erreur est servenue")

def creatDir(PATH):
    try:
        os.mkdir(input("Quel sera son nom? "))
    except FileExistsError:
        print("Existe déjà")
    except OSError:
        print("Une erreur est survenue")

def cpDir(PATH):
    try:
        shutil.copytree(os.getcwd() + "/" + input("Quel repo ?") + "/", input("Ou est-ce qu'on copie? "))
    except FileExistsError:
        print("Le répertoire de destination existe déjà.")
    except shutil.Error:
        print("Une erreur est survenue")

def mvDir(PATH):
    try:
        shutil.move(os.getcwd() + "/" + input("Quel repo ?") + "/", os.getcwd() + "/" + input("Où ça?"))
    except FileNotFoundError:
        print("Repertoire n'existe pas")
    except shutil.Error:
        print("Une erreur est survenue")
    

def rmDir(PATH):
    try:
        os.rmdir(os.getcwd() + "/" + input("Quel repertoir? "))
    except FileNotFoundError:
        print("N'existe pas")
    except OSError:
        print("Une erreur est survenue")

def openFile(PATH):
    try:
        with open(os.getcwd() + "/" + input("Quel fichier? "), 'r') as fd:
            print(fd.read())
    except FileNotFoundError:
        print("N'existe pas")
    except IOError:
        print("Une erreur est survenue")

def creatFile(PATH):
    try:
        open(os.getcwd() + "/" + input("Nom du fichier "), 'w')
    except IOError:
        print("Une erreur est survenue")

def cpFile(PATH):
    print("cpFile")
    sys.exit(0)

def mvFile(PATH):
    try:
        shutil.move(os.getcwd() + "/" + input("Quel fichier ?") + "/", input("Ou est-ce qu'on copie? "))
    except FileExistsError:
        print("Le fichier existe déjà.")
    except shutil.Error:
        print("Une erreur est survenue")

def rmFile(PATH):
    try:
        os.remove(os.getcwd() + "/" + input("Quel fichier?"))
    except FileNotFoundError:
        print("Fichier n'existe pas")
    except OSError:
        print("Erreur survenue")

def printer():
    print("1. Listez les repertoires")
    print("2. Se deplacer dans un répertoire")
    print("3. Renommer un répertoire/sous répertoire/fichier")
    print("4. Créer repertoire")
    print("5. Copier un répertoire")
    print("6. Déplacer un répertoire")
    print("7. Supprimer un répertoire")

    print("8. Listez les fichiers")
    print("9. Ouvrir fichier")
    print("10. Créer un fichier")
    print("11. Copier un fichier")
    print("12. Déplacer un fichier")
    print("13. Supprimer un fichier")

    print("0. Quitter")


funcTab = [lsDir, openDir, renameDir, creatDir, cpDir, mvDir, rmDir, lsFile, openFile, creatFile, cpFile, mvFile, rmFile]

def cli(PATH):
    printer()
    cmd = input("$> ")
    if not cmd.isdigit(): cli(PATH)
    cmd = int(cmd)
    if cmd > 14: cli(PATH)
    elif cmd == 0: return 0
    else:
        PATH = funcTab[cmd - 1](PATH)
        cli(PATH)

def main():
    l = "ftppython"
    p = "ftppython123"
    ftp_host = "37.44.238.144"

    try:
        MonSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        MonSocket.connect((ftp_host, 21))
    except socket.error:
        print("La connexion a échoué.")
        sys.exit(1)
    try:
        ftp = FTP.FTP()
        ftp.connect(ftp_host)
        ftp.login(l, p)
        print("Connexion établie avec le serveur.")
        cli(os.getcwd())
        ftp.quit()

    except FTP as err:
        print("Erreur de connexion:", str(err))

if __name__ == "__main__":
    main()