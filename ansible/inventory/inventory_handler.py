#!/usr/bin/env python
# -*- coding:utf-8 -*-

import json


def fetch_tfstate():
    with open("../terraform/terraform.tfstate", "r", encoding="utf-8") as file:
        return json.loads(file.read())


def main():
    inventory = {
        "all": {"hosts": []},
        "_meta": {"hostvars": {}},
    }
    tfstate = fetch_tfstate()
    # Uncomment below to see the tfstate object
    #
    # print(tfstate["outputs"])

    inventory_gp = {}

    for output_key in tfstate["outputs"]:
        match output_key:
            case "platform_ip_address":
                inventory_gp = inventory["all"]
            case _:
                continue

        for ip_address in tfstate["outputs"][output_key]["value"]:
            inventory_gp["hosts"].append(ip_address)

    inventory["all"]["vars"] = {
        "ansible_user": "ubuntu",
        "ansible_sudo_pass": tfstate["outputs"]["cluster_pass"]["value"],
    }

    print(json.dumps(inventory))


if __name__ == "__main__":
    main()
