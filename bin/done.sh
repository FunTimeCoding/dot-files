#!/bin/sh -e

INITIAL_STATE=$(osascript -e 'output muted of (get volume settings)')

if [ "${INITIAL_STATE}" = true ]; then
    osascript -e 'set volume output muted false'
fi

osascript -e 'set volume output volume 50'
say done

if [ "${INITIAL_STATE}" = true ]; then
    osascript -e 'set volume output muted true'
fi
