import asyncio
import logging
import signal
from logging import Logger
from time import perf_counter

from humanfriendly import format_timespan

from . import config

logger: Logger = logging.getLogger(__name__)


async def run(settings):
    pass  # do something epic


async def shutdown(signal):
    logger.debug(f"Received exit signal {signal.name}...")
    tasks = [t for t in asyncio.all_tasks() if t is not asyncio.current_task()]
    for task in tasks:
        logger.debug(f"cancel: {task._coro.__name__}")
        task.cancel()

    logger.debug("Cancelling outstanding tasks")
    await asyncio.gather(*tasks, return_exceptions=True)


async def signal_handle(signal, components, loop):
    logger.info("Received exit signal %s", signal.name)
    await shutdown(components, loop)


def main() -> None:
    settings = config.get_config()
    logging.info("main")
    start = perf_counter()

    loop = asyncio.get_event_loop()
    # loop.set_debug(True)

    signals = (signal.SIGHUP, signal.SIGTERM, signal.SIGINT)
    for s in signals:
        loop.add_signal_handler(s, lambda s=s: asyncio.create_task(shutdown(s)))

    loop.run_until_complete(run(settings))
    finished = perf_counter() - start
    pretty_finished = format_timespan(finished)
    logger.info("Completed in %s", pretty_finished)


if __name__ == "__main__":
    main()
