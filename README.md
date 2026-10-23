# serverlin-homelab

A secure, low-power home storage server built on a spare laptop running
Ubuntu Server 26.04 LTS. It shares files to Windows and Android, is reachable
from anywhere over Tailscale, and doubles as my hands-on Linux practice lab.

## Hardware and network

| Item | Detail |
|------|--------|
| Machine | HP 245 14" G10, 8 GB RAM, 256 GB NVMe |
| OS | Ubuntu Server 26.04 LTS |
| Network | Wired via USB 3.0 Ethernet adapter, wifi as fallback |
| Clients | Windows PC, Android phone |

## Architecture

```
[PC / phone] --home LAN------+
                             +--> serverlin --> shared folder
[PC / phone] --Tailscale-----+     (Samba, Filebrowser, Cockpit, SSH)
```

## What I built

- **File sharing:** Samba share with a recycle bin for recoverable deletes
- **Remote access:** Tailscale, with key expiry disabled for the server
- **Web file manager:** Filebrowser running as a systemd service with an
  admin account and a least-privilege daily user
- **Management:** Cockpit web dashboard
- **Security:** UFW deny-by-default (LAN and Tailscale only), key-only SSH,
  unattended security updates, restrictive file permissions on network configs
- **Laptop-as-server tuning:** lid-close ignored, battery shown in the prompt

## Troubleshooting case study: slow file copies

| Stage | What happened |
|-------|---------------|
| Symptom | File copies to the server were slow |
| Investigation | Tested the wifi driver and power-management workarounds; measured each hop |
| Root cause | The server's wifi link was the bottleneck |
| Fix | Added a wired USB Ethernet adapter and preferred it using netplan route metrics (wired 100, wifi 600) |
| Result | About 2 ms to the router; phone measured ~95 Mbit/s download from the server |
| Cleanup | Removed the unneeded workarounds and verified everything after a reboot |

Lessons: measure before changing things, change one variable at a time, back
up every config before editing, and verify after reboot.

## Repository layout

```
configs/    sanitized copies of netplan, Samba and systemd unit files
scripts/    shell scripts
docs/       build notes and write-ups
```

## Key skills demonstrated

Linux administration, networking (netplan, routing), Samba, firewalling (UFW),
SSH hardening, systemd services, troubleshooting, documentation, Git.

## Roadmap

- [ ] Automated backups to an external disk (rsync + systemd timer)
- [ ] Low-battery safe shutdown script
- [ ] Docker and a reverse proxy
- [ ] Ansible playbook to rebuild the server from scratch

## Author

R M SARAN - rmsaran2000@gmail.com
