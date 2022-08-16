# Introduction

There are a few traffic steering options offered by Netskope to steer traffic to netskope cloud. This Infrastructure as Code (IaC) will help you configure your Azure environment for the following steering options:

- **IPSec** <br>
IPSec can steer HTTP(S) and non-HTTP(S) traffic to the Netskope cloud. We'll configure the source peer IPSec device i.e. Azure VPN Gateway to send all traffic over the IPSec VPN tunnel to Netskope cloud. The Netskope IPSec gateway validates the source identity of the tunnel configured in the Netskope admin console. If the tunnel identity is not known, the tunnel is not established. This IaC will configure IPSec tunnels from your Azure VPN Gateway to two different Netskope POPs of your chosing. To use this template and configure for this deployment type, ensure you have Netskope Cloud Firewall License enabled.

- **Expilict Proxy Over IPsec** <br>
Explicit Proxy over IPSec is browser-centric traffic steering mechanism and you can use an existing or new PAC file, or manual proxy settings. To configure browsers for this deployment, please refer to product documentation. 

To learn more about Netskope traffic steering options please refer to the [Traffic Steering](https://docs.netskope.com/en/traffic-steering.html)

This IaC template deploys and configures the following;

- Create an Azure VPN gateway to an existing virtual network in the GatewaySubnet.
- Create two local network gateway resources to represent Netskope's point of presence(POPs). New Netskope's point of presence(POPs) are continusly being added and the complete list is available from the Netskope UI to get the POP IP addresses.
- Create two site to site vpn connections with the supplied Netskope's POP IPs. 
   - To Configure Azure VPN gateway for Explicit Proxy Over IPSec deployment, you will set the value of the ` var.epot_config ` to "Yes".
- Provides VPN gateway's Public IP Address as template output.

## High Level Steps

- Collect Netskope's POP IP addresses for IPSec configuration from the Netskope Admin Web Console.
- Provide input variables as per the requirements and run this template to deploy and configure resources in your Azure environment.
- Add IPSec tunnel configuration in Netskope Admin Web Console by using Azure VPN gateway public ip address provided as part of the template output. 
- Verify tunnel status from Azure and Netskope's Admin Web Console.
- Configure routing and user defined routes (UDR's) in your Azure environment to send traffic to Azure VPN gateway as per your network design.
- Create netskope policies as needed and verify connectivity etc.

## Architecture Diagram

### Example
In this example architecture diagram, the hub virtual network acts as a central point of connectivity to many spoke virtual networks. The hub is used as the connectivity point to other networks and running the virtual network gateway that enables the virtual network to connect to the VPN device e.g. netskope in this case. The spoke virtual networks are peered with the hub and are used to isolate workloads in their own virtual networks, managed separately from other spokes. Each workload might include multiple tiers, with multiple subnets etc. The virtual networks are connected using a peering connections. Once peered, the virtual networks exchange traffic by using the Azure backbone without the need for a router. 

For this example, once you have deployed and configured IPSec tunnels using this template, you will then add a UDR to your spokes subnets using VPN gateway as a next hop. The table below shows the required routes for each steering option. For example, for Explicit Proxy Over IPsec deployment you will add the first route.


|   Traffic Steering Type      |          Address Prefix              |   Next Hope Type      |
| ---------------------------- | ------------------------------------ | --------------------- |
| Explicit Proxy Over IPsec    | 163.116.128.80/32 & 163.116.128.81/32| VirtualNetworkGateway |
| IPSec                        | 0.0.0.0/0                            | VirtualNetworkGateway |


![](.//images/azure-vpngw.png)

*Fig 1. Netskope Traffic Steering with Azure VPN Gateway*

## IPSec Policy

Each tunnel endpoint device must match the parameters for a successful tunnel establishment. In this IaC, the IPSec Policy defaults are set as follows;

``` sh
ipsec_policy {
    dh_group         = "DHGroup2048"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "GCMAES256"
    ipsec_integrity  = "GCMAES256"
    pfs_group        = "PFS2048"
    sa_datasize      = "102400000"
    sa_lifetime      = "7200"
  }

```
When configuring Netskope end for this IPSec tunnel establisment, under "Encryption Cipher" you will have to pick `AES256-GCM` to match with this policy.

## Deployment

To deploy this template in Azure:
- Clone the GitHub repository for this deployment.
- Customize variables in the `terraform.tfvars.example` and `variables.tf` file as needed and rename `terraform.tfvars.example` to `terraform.tfvars`.
- Change to the repository directory and then initialize the providers and modules.

   ```sh
   $ cd <Code Directory>
   $ terraform init
    ```
- Submit the Terraform plan to preview the changes Terraform will make to match your configuration.
   ```sh
   $ terraform plan
   ```
- Apply the plan. The apply will make no changes to your resources, you can either respond to the confirmation prompt with a 'Yes' or cancel the apply if changes are needed.
   ```sh
   $ terraform apply
   ```
- Output will provide Azure VPN gateway public ip address that is necessary to complete vpn tunnel configuration in Netskope's Admin UI.

   ```sh
    Outputs:

    public_ip_address = <VPN Gateway Public IP>

   ```

## Destruction
- To destroy this deployment, use the command:
   ```sh
   $ terraform destroy
   ```

## Support
Netskope-provided scripts in this and other GitHub projects do not fall under the regular Netskope technical support scope and are not supported by Netskope support services.# tf-e-netskope-vpngw-azure
