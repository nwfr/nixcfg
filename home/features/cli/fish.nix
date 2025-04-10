{ config, lib, ... }:
with lib;
let
  cfg = config.features.cli.fish;
in
{
  options.features.cli.fish.enable = mkEnableOption "enable extended fish configuration";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      loginShellInit = ''
        set -x NIX_PATH nixpkgs=channel:nixos-unstable
        set -x NIX_LOG info
        set -x TERMINAL ghostty
        source /run/agenix/${config.home.username}-secrets

        if test (tty) = "/dev/tty1"
          exec Hyprland &> /dev/null
        end
      '';
      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "cd." = "cd /home/n00r/.dotfiles && ls -A";
        cdn = "cd /home/n00r/nixcfg && ls -A";
        cds = "cd /home/n00r/.ssh && ls -A";
        cdb = "cd /home/n00r/.local/bin && ls -A";
        cdh = "cd /home/n00r/.local/share && ls -A";
        cdp = "cd /data/projetcs && ls -A";
        data = "cd /data  && ls -A";
        bak1 = "cd /bak1  && ls -A";
        bak2 = "cd /bak2  && ls -A";

        # ls & eza
        ls = "eza";
        l = "ls -l";
        la = "ls -a";
        ll = "ls -la";
        lt = "ls --tree";

        salias = "source ~/.config/fish/config.fish";

        # hyprland
        hl = "hyprland";
        htc = "hyprctl";

        # rsync & copy & rclone
        cp = "cp -iv";
        syn = "rsync -ah --progress";
        mv = "mv -iv";
        mkd = "mkdir -pv";
        rclone = "rclone --no-check-certificate";

        # These common commands are just too long! Abbreviate them.
        ka = "killall";
        sdn = "shutdown -h now";
        e = "$EDITOR .";
        v = "$EDITOR";
        t = "tmux";
        z = "zellij";
        zz = "zellij-ps";
        grep = "rg";
        ps = "procs"; # ncmpcpp
        ncm = "ncmpcpp";

        # bluetoothctl
        btc = "bluetoothctl";

        # systemctl
        sys = "sudo systemctl start";
        syp = "sudo systemctl stop";
        syt = "sudo systemctl status";
        syr = "sudo systemctl restart";
        sye = "sudo systemctl enable --now";
        syd = "sudo systemctl disable";

        # clear terminal
        cx = "clear";

        # youtube-dl
        # Download best format available but no better than 720p & 480p
        yt = "yt-dlp --add-metadata -i";
        yta = "yt -x -f bestaudio/best";
        ytdl7 = "yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'";
        ytdl4 = "yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=720]'";

        # symfony

        sf = "symfony";
        sfc = "symfony console";
        sfss = "symfony serve -d";
        sfsp = "symfony server:stop";
        sfst = "symfony server:status";
        sfccc = "symfony console cache:clear";
        sfclt = "symfony console lint:twig";

        #git
        ga = "git add -A";
        gb = "git branch";
        gc = "git commit -m";
        gl = "git log";
        gm = "git merge";
        gp = "git push -u";
        gu = "git pull";
        gs = "git status";
        gco = "git checkout";
        gcb = "git checkout -b";
        gcm = "git checkout main";
        gcd = "git checkout dev";
        gcp = "git checkout prod";
        gct = "git checkout testing";
        guc = "git reset --hard HEAD~1";

        # ssh
        o2ssh = "ssh o2";
        htssh = "ssh ht";
        imssh = "ssh im";
        nbssh = "sudo netbird ssh n00r@100.89.37.52";
        nbup = "netbird up --allow-server-ssh";

        # search & find
        findr = "sudo find / -name";

        # cat
        cat = "bat -p";

        #VScode : move extention dir from home to local/share
        vscodium = "vscodium --extensions-dir '$XDG_DATA_HOME/vscode'";

        # vnstat
        vnstatme = "vnstat --config $XDG_CONFIG_HOME/vnstat/.vnstatrc";

        # journalctl errors on current boot (jee : Eournal Emerg Err)
        jee = "journalctl -b -p 'emerg'..'err'";

        # compression
        # ls.... -> Listing contents of tar file
        untargz = "tar --same-owner -zxvf";
        untarbz = "tar --same-owner -xjvf";
        lstargz = "tar -ztvf";
        lstarbz = "tar -jtvf";
        targz = "tar -zcvf";
        tarbz = "tar -cjvf";

        # trash - trash-cli
        rmn = "rm -vI";
        rm = "trash-put";
        rmv = "rm -rvI";
        tempty = "trash-empty ; sudo trash-empty ; sudo -H trash-empty";
        tlist = "trash-list";
        srmt = "sudo trash-put";

        # file size & storage
        fdisk = "sudo fdisk -l";
        uuid = "sudo vol_id -u";
        mnt = "mount | grep -E ^/dev | column -t"; # show mounted drives
        dirsize = "sudo du -hx --max-depth=1";
        dirusage = "du -ch | grep total"; # Grabs the disk usage in the current directory
        diskusage = "df -hl --total | grep total"; # Gets the total disk usage on your machine
        partusage = "df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs"; # Shows the individual partition usages without the temporary memory values
        usage10 = "du -hsx * | sort -rh | head -10"; # Gives you what is using the most space. Both directories and files. Varies on current directory

        # ufw
        ufwe = "sudo ufw enable";
        ufwd = "sudo ufw disable";
        ufwa = "sudo ufw allow";
        ufwm = "sudo ufw limit";
        ufws = "sudo ufw status numbered";
        ufwt = "sudo ufw delete";
        ufwr = "sudo ufw reload";

        # networking
        ptused = "sudo netstat -tulpn | grep LISTEN";
        ptshow = "netstat -lnptu";
        ptlisten = "lsof -i -n | egrep 'COMMAND|LISTEN'";
        ping = "ping -c 5";
        ipe = "curl ipinfo.io/ip";
        ipi = "ipconfig getifaddr wlan0";

        # system monitoring
        meminfo = "free -m -l -t"; # memory usage
        psmem = "ps auxf | sort -nr -k 4"; # get top process eating memory
        psmem10 = "ps auxf | sort -nr -k 4 | head -10"; # get top 10 process eating memory
        pscpu = "ps auxf | sort -nr -k 3"; # get top process eating cpu
        pscpu10 = "ps auxf | sort -nr -k 3 | head -10"; # get top 10 process eating cpu
        cpuinfo = "lscpu"; # Get server cpu info
        gpumeminfo = "grep -i --color memory /var/log/Xorg.0.log"; # get GPU ram on desktop / laptop
        free = "free -h";

        # podman - All podman commands start with "pm"
        cdpm = "cd ~/podman";
        pp = "sudo podman stop $(sudo podman ps -a -q)"; # usage: pmp container_name
        ppa = "sudo podman stop $(sudo podman ps -aq)"; # stop all containers
        prm = "sudo podman rm $(sudo podman ps -a -q)"; # usage: pmrm container_name
        ppvol = "sudo podman volume prune"; # remove unused volumes
        ppsys = "sudo podman system prune -a"; # remove unsed podman data
        ppimg = "sudo podman rmi $(sudo podman images -q)"; # remove unused podman images
        pprune = "pmpvol ; pmpimg ; pmpsys"; # remove unused data, volumes, and images (perfect for safe clean up)
        pmx = "sudo podman exec -ti"; # usage: dexec container_name (to access container terminal)
        pmpss = "sudo podman ps -a"; # running podman processes
        pmps = "sudo podman ps -a --format 'table {{.Names}}\t{{.State}}\t{{.Status}}\t{{.Image}}' | (sed -u 1q; sort)"; # running podman processes as nicer table
        pmdf = "sudo podman system df"; # podman data usage (/var/lib/podman)
        pml = "sudo podman logs -tf --tail='50'"; # usage: dlogs container_name
        pmlsize = "sudo du -ch $(sudo podman inspect --format='{{.LogPath}}' $(sudo podman ps -qa)) | sort -h"; # see the size of podman containers
        pmips = "sudo podman ps -q | xargs -n 1 sudo podman inspect -f '{{.Name}}%tab%{{range .NetworkSettings.Networks}}{{.IPAddress}}%tab%{{end}}' | sed 's#%tab%#\t#g' | sed 's#/##g' | sort | column -t -N NAME,IP\(s\) -o $'\t'";
        dp600 = "sudo chown -R root:root $HOME/podman/secrets ; sudo chmod -R 600 $HOME/podman/secrets ; sudo chown -R root:root $HOME/podman/.env ; sudo chmod -R 600 $HOME/podman/.env"; # re-lock permissions
        dp777 = "sudo chown -R $USER:$USER $HOME/podman/secrets ; sudo chmod -R 777 $HOME/podman/secrets ; sudo chown -R $USER:$USER $HOME/podman/.env ; sudo chmod -R 777 $HOME/podman/.env"; # open permissions for editing

        # COMPOSE - All podman Compose commands start with "pc"
        pcl = "sudo podman compose logs -tf --tail='50' "; # usage: dclogs container_name
        pcu = "sudo podman compose up -d"; # up the stack
        pcd = "sudo podman compose down"; # down the stack
        pcr = "sudo podman compose up -d --force-recreate"; # usage: dcrec container_name
        pcp = "sudo podman compose stop"; # usage: dcstop container_name
        pct = "sudo podman compose restart"; # usage: dcrestart container_name
        pcs = "sudo podman compose start"; # usage: dcstart container_name
        pco = "sudo podman compose up -d --remove-orphans"; # up the stack
        pcpull = "sudo podman compose pull"; # usage: dcpull to pull all new images or dcpull container_name
        traefiklogs = "tail -f $HOME/docker/logs/traefik/traefik.log"; # tail traefik logs

      };
    };
  };
}
