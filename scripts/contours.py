"""Marching squares: the level curves of a function sampled on a grid, as line segments."""

def segments(values, xs, ys, level):
    """`values[j][i]` is the value at `(xs[i], ys[j])`. Cells with a `None` corner are skipped."""
    out = []
    for j in range(len(ys) - 1):
        for i in range(len(xs) - 1):
            corners = [(xs[i], ys[j], values[j][i]), (xs[i + 1], ys[j], values[j][i + 1]),
                       (xs[i + 1], ys[j + 1], values[j + 1][i + 1]),
                       (xs[i], ys[j + 1], values[j + 1][i])]
            if any(c[2] is None for c in corners):
                continue
            points = []
            for k in range(4):
                (x0, y0, v0), (x1, y1, v1) = corners[k], corners[(k + 1) % 4]
                if (v0 < level) != (v1 < level):
                    f = (level - v0) / (v1 - v0)
                    points.append((x0 + f * (x1 - x0), y0 + f * (y1 - y0)))
            if len(points) == 2:
                out.append(tuple(points))
            elif len(points) == 4:  # saddle: pair up the crossings
                out.append((points[0], points[1]))
                out.append((points[2], points[3]))
    return out
