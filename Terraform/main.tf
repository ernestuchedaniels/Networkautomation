resource "iosxe_interface_ethernet" "r1gi2" {
  device            = "iosxe-router-1"
  type              = "GigabitEthernet"
  name              = "4"
  shutdown          = false
  ipv4_address      = "192.168.0.14"
  ipv4_address_mask = "255.255.255.0"
}

resource "iosxe_interface_ethernet" "r2gi2" {
  device            = "iosxe-router-2"
  type              = "GigabitEthernet"
  name              = "4"
  shutdown          = false
  ipv4_address      = "192.168.0.15"
  ipv4_address_mask = "255.255.255.0"
}

resource "iosxe_interface_ethernet" "r1gi1" {
  device            = "iosxe-router-1"
  type              = "GigabitEthernet"
  name              = "1"
  shutdown          = false
  ipv4_address      = "192.168.2.1"
  ipv4_address_mask = "255.255.255.0"
}

resource "iosxe_interface_ethernet" "r2gi1" {
  device            = "iosxe-router-2"
  type              = "GigabitEthernet"
  name              = "1"
  shutdown          = false
  ipv4_address      = "192.168.1.2"
  ipv4_address_mask = "255.255.255.0"
}
resource "iosxe_interface_ethernet" "r1lo0" {
  device            = "iosxe-router-1"
  type              = "GigabitEthernet"
  name              = "3"
  shutdown          = false
  ipv4_address      = "10.151.0.1"
  ipv4_address_mask = "255.255.255.255"
}

resource "iosxe_interface_ethernet" "r2lo0" {
  device            = "iosxe-router-2"
  type              = "GigabitEthernet"
  name              = "3"
  shutdown          = false
  ipv4_address      = "10.10.0.2"
  ipv4_address_mask = "255.255.255.255"
}
resource "iosxe_ospf" "ospf1" {
  for_each   = toset(var.routers)
  device     = each.key
  process_id = 1
  networks = [
    {
      ip       = "192.168.10.0"
      wildcard = "0.0.0.255"
      area     = "0"
    },
    {
      ip       = "192.168.0.0"
      wildcard = "0.0.0.255"
      area     = "0"
    }
  ]
}

resource "iosxe_ospf" "ospfnetr1" {
  device     = iosxe-router-1
  process_id = 1
  networks = [
    {
      ip       = "10.151.0.0"
      wildcard = "0.0.0.255"
      area     = "0"
    },
  ]
  depends_on = [r1lo0]
}

resource "iosxe_ospf" "ospfnetr2" {
  device     = iosxe-router-2
  process_id = 1
  networks = [
    {
      ip       = "10.10.0.0"
      wildcard = "0.0.0.255"
      area     = "0"
    },
  ]
  depends_on = [r2lo0]
}