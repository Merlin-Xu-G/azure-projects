from azure.devops.connection import Connection
from msrest.authentication import BasicAuthentication
import pprint


class AdoClient:
    def __init__(self, token: str, organization_url: str):
        self.token = token
        self.organization_url = organization_url

        # Create a connection to the org
        self.credentials = BasicAuthentication('', self.token)
        self.connection = Connection(base_url=self.organization_url, creds=self.credentials)

    def build(self):
        build_client = self.connection.clients.get_build_client()
        build = {
            'definition': {
                'id': 2
            }
        }
        response = build_client.queue_build(build=build, project="Merlin")
        return response

