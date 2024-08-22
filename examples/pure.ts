function doThings(...input: unknown[]) {}

function nix(...input: unknown[]): Output {
    doThings(input)
    return {};
}

type Output = {};