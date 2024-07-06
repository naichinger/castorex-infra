from diagrams import Cluster, Diagram, Edge
from diagrams.onprem.compute import Server
from diagrams.generic.network import Firewall
from diagrams.saas.cdn import Cloudflare

with Diagram("Terraform Architecture Diagram",filename="network", show=False):
    with Cluster("Hetzner Infrastructure"):
        with Cluster("Castorex Network 10.0.0.0/16"):
            with Cluster("Castorex Sub Network 10.0.0.0/24"):
                workerNVps = Server("nth. Worker Node")
                worker1Vps = Server("1. Worker Node")
                masterVps = Server("Master Node")

        fw = Firewall("Hetzner Firewall")
    with Cluster("Cloudflare Infrastructure"):
        dnsRecord = Cloudflare("DNS Record")
        tunnel = Cloudflare("Cloudflare Tunnel")

    tunnel >> Edge(label="Accesses K3s internal service subnet ") >> worker1Vps

    dnsRecord >> fw
    fw >> masterVps
    
'''    
    dns = Route53("dns")
    web = ECS("service")
    

    with Cluster("DB Cluster"):
        db_primary = RDS("primary")
        db_primary - [RDS("replica1"),
                     RDS("replica2")]

    dns >> web >> db_primary
'''