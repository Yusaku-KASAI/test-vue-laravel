FROM node:lts

COPY ./vue /opt/app/vue

WORKDIR /opt/app/vue

RUN if [ -f package.json ]; then \
    npm install; \
    fi

EXPOSE 3000
# exposeでは実際のポートに影響しない

ENTRYPOINT [ "bash", "-c", "if [ -f package.json ]; then npm run dev; else echo 'No package.json found. Keeping Container alive.' && tail -f /dev/null; fi" ]
