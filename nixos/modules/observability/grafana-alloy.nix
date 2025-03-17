# grafana-alloy.nix - https://perrrkele.grafana.net/connections/add-new-connection/linux-node?page=alloy
# Enables Grafana Alloy for monitoring
{ ... }:
{
  services.alloy = {
    enable = false;
    configPath = "/etc/alloy";
    extraFlags = [
      # "--server.http.listen-addr=127.0.0.1:12346"
      # "--disable-reporting"
    ];
  };

  /*
    environment = {
      variables = {
        GCLOUD_FM_URL = "https://fleet-management-prod-008.grafana.net";
        GCLOUD_FM_POLL_FREQUENCY = "60s";
        GCLOUD_FM_HOSTED_ID = "1110459";
        ARCH = "amd64";
        GCLOUD_RW_API_KEY = "glc_eyJvIjoiMTI5MDQ3OSIsIm4iOiJzdGFjay0xMTEwNDU5LWFsbG95LXBlcnJya2VsZSIsImsiOiJ1SjFRYTB4NjhmSHVsTk40cDlaNzc4dzgiLCJtIjp7InIiOiJwcm9kLXVzLWVhc3QtMCJ9fQ==";
      };

      etc."alloy/config.alloy" = {
        mode = "0644";
        user = "root";
        group = "root";

        text = ''
          discovery.relabel "integrations_node_exporter" {
            targets = prometheus.exporter.unix.integrations_node_exporter.targets

            rule {
              target_label = "instance"
              replacement  = constants.hostname
            }

            rule {
              target_label = "job"
              replacement = "integrations/node_exporter"
            }
          }

          prometheus.exporter.unix "integrations_node_exporter" {
            disable_collectors = ["ipvs", "btrfs", "infiniband", "xfs", "zfs"]

            filesystem {
              fs_types_exclude     = "^(autofs|binfmt_misc|bpf|cgroup2?|configfs|debugfs|devpts|devtmpfs|tmpfs|fusectl|hugetlbfs|iso9660|mqueue|nsfs|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|selinuxfs|squashfs|sysfs|tracefs)$"
              mount_points_exclude = "^/(dev|proc|run/credentials/.+|sys|var/lib/docker/.+)($|/)"
              mount_timeout        = "5s"
            }

            netclass {
              ignored_devices = "^(veth.*|cali.*|[a-f0-9]{15})$"
            }

            netdev {
              device_exclude = "^(veth.*|cali.*|[a-f0-9]{15})$"
            }
          }

          prometheus.scrape "integrations_node_exporter" {
            targets    = discovery.relabel.integrations_node_exporter.output
            forward_to = [prometheus.relabel.integrations_node_exporter.receiver]
          }

          prometheus.relabel "integrations_node_exporter" {
            forward_to = [prometheus.remote_write.metrics_service.receiver]

            rule {
              source_labels = ["__name__"]
              regex         = "node_scrape_collector_.+"
              action        = "drop"
            }
          }

          loki.source.journal "logs_integrations_integrations_node_exporter_journal_scrape" {
            max_age       = "24h0m0s"
            relabel_rules = discovery.relabel.logs_integrations_integrations_node_exporter_journal_scrape.rules
            forward_to    = [loki.write.grafana_cloud_loki.receiver]
          }

          local.file_match "logs_integrations_integrations_node_exporter_direct_scrape" {
            path_targets = [{
              __address__ = "localhost",
              __path__    = "/var/log/{syslog,messages,*.log}",
              instance    = constants.hostname,
              job         = "integrations/node_exporter",
            }]
          }

          discovery.relabel "logs_integrations_integrations_node_exporter_journal_scrape" {
            targets = []

            rule {
              source_labels = ["__journal__systemd_unit"]
              target_label  = "unit"
            }

            rule {
              source_labels = ["__journal__boot_id"]
              target_label  = "boot_id"
            }

            rule {
              source_labels = ["__journal__transport"]
              target_label  = "transport"
            }

            rule {
              source_labels = ["__journal_priority_keyword"]
              target_label  = "level"
            }
          }

          loki.source.file "logs_integrations_integrations_node_exporter_direct_scrape" {
            targets    = local.file_match.logs_integrations_integrations_node_exporter_direct_scrape.targets
            forward_to = [loki.write.grafana_cloud_loki.receiver]
          }
        '';
      };
    };
  */
}
