# node-canvas-lambda

A node-canvas layer for AWS Lambda using ARM64 and Node v20.
Forked from Jonah Werre's [node-canvas-lambda](https://github.com/jwerre/node-canvas-lambda)

## Build

Build new layers using the Dockerfile and copy them to the build folder.
Be sure to have Docker installed then run the following command:

```zsh
make build
```

The default version of Nodejs is 20. To build for a different node version set
the `NODE_VERSION`:

```zsh
make build NODE_VERSION=18
```

## Publish

Upload the layers to AWS into your default region. This will build the layers
if they have not already been built.

```zsh
make publish
```

## Test

A lambda image (e.g. `public.ecr.aws/lambda/nodejs:20-arm64` ) can be used to
test the layers by loading the layers and running a simple lambda handler that
uses canvas.

The following command will unzip the layers and mount the layer folders into to
the `/opt/` folder of the lambda container and then run the `test.js` handler:

```zsh
make test
```

If the test worked correctly the output should be a data URI.
e.g.: `"data:image/png;base64,iVBORw0KGgoAAAA...`. You can copy the URI and
paste it into our browser's url bar to see the image.

## Debug

The build image can be used to debug any issues with the layers.

Use `make debug` to start an interactive bash session in the container where you
can use `ldd` or [`lddtree`](https://github.com/ncopa/lddtree) to examine the
`canvas.node` binary:

```zsh
ldd nodejs/node_modules/canvas/build/Release/canvas.node
```
