from os import environ
from microsoft_agents.hosting.core import AgentApplication, AgentAuthConfiguration
from microsoft_agents.hosting.aiohttp import (
    start_agent_process,
    jwt_authorization_middleware,
    CloudAdapter, jwt_authorization_decorator,
)
from aiohttp.web import Request, Response, Application, run_app
import json

import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

def start_server(
    agent_application: AgentApplication, auth_configuration: AgentAuthConfiguration
):
    @jwt_authorization_decorator
    async def entry_point(req: Request) -> Response:
        agent: AgentApplication = req.app["agent_app"]
        adapter: CloudAdapter = req.app["adapter"]
        return await start_agent_process(
            req,
            agent,
            adapter,
        )

    async def pipeline_hooks(req: Request) -> Response:
        print(f"{repr(req)}")
        req_json = await req.json()
        # print(f"{repr(req_json)}")
        build_id = req_json['resource']['definition']['id']
        build_number = req_json['resource']['buildNumber']
        print(build_id)
        print(build_number)
        return Response(text=repr({"build_id": build_id, "build_number": build_number}))

    APP = Application()
    APP.router.add_post("/api/messages", entry_point)
    APP.router.add_post("/ado/hooks", pipeline_hooks)
    APP.router.add_get("/status", lambda _: Response(status=200, body="up"))
    APP["agent_configuration"] = auth_configuration
    APP["agent_app"] = agent_application
    APP["adapter"] = agent_application.adapter

    try:
        run_app(APP, host="0.0.0.0", port=environ.get("PORT", 3978))
    except Exception as error:
        raise error
