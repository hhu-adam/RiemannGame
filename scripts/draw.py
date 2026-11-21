"""Cover and world image for the Riemann game: |ζ| in ℝ³ (cover) and ζ on the plane (world).

Plain Python, no dependencies. Writes `cover.svg` and `background.svg` to the current
folder; convert them with ImageMagick's internal renderer, e.g. from `scripts/`:

    python3 draw.py
    convert -background none MSVG:cover.svg -depth 8 ../images/cover.png
    convert -background none MSVG:background.svg -depth 8 ../images/riemann-bg.png
"""
import math
from zeta import zeta, ZEROS

INK = "#334155"       # slate, lines
SOFT = "#94a3b8"      # light slate, grid
ACCENT = "#c2410c"    # burnt orange, zeros and critical line
FONT = "DejaVu Serif"

def height(s):
    if abs(s - 1) < 1e-9:
        return 2.2  # the pole
    h = abs(zeta(s))
    return 2.2 * math.tanh(h / 2.2)  # compress the growth and the pole

class View:
    """Axonometric projection: t to the right and up, σ towards the viewer, z up."""
    def __init__(self, scale, ox, oy, et=(1.0, -0.16), es=(-0.55, 0.42), ez=(0.0, -1.0),
                 sstretch=9.0, zstretch=5.0):
        self.scale, self.ox, self.oy = scale, ox, oy
        self.et, self.es, self.ez = et, es, ez
        self.sstretch, self.zstretch = sstretch, zstretch

    def __call__(self, sigma, t, z):
        x = t * self.et[0] + sigma * self.sstretch * self.es[0] + z * self.zstretch * self.ez[0]
        y = t * self.et[1] + sigma * self.sstretch * self.es[1] + z * self.zstretch * self.ez[1]
        return self.ox + self.scale * x, self.oy + self.scale * y

def pts(points):
    return " ".join(f"{x:.1f},{y:.1f}" for x, y in points)

def line(p, q, color, width, dash=None, opacity=1.0):
    d = f' stroke-dasharray="{dash}"' if dash else ""
    return (f'<line x1="{p[0]:.1f}" y1="{p[1]:.1f}" x2="{q[0]:.1f}" y2="{q[1]:.1f}" '
            f'stroke="{color}" stroke-width="{width}" stroke-opacity="{opacity}"{d}/>')

def text(p, s, size, color=None, anchor="start", italic=True):
    color = color or INK
    style = ' font-style="italic"' if italic else ""
    return (f'<text x="{p[0]:.1f}" y="{p[1]:.1f}" font-family="{FONT}" font-size="{size}" '
            f'fill="{color}" stroke="none" text-anchor="{anchor}"{style}>{s}</text>')

def axes(v, smin, smax, tmax, zmax, w, label_size, ink=INK):
    o = []
    o.append(line(v(smin, 0, 0), v(smax, 0, 0), ink, w))
    o.append(line(v(smin, 0, 0), v(smin, tmax, 0), ink, w))
    o.append(line(v(smin, 0, 0), v(smin, 0, zmax), ink, w))
    if label_size:
        o.append(text(v(smax, 0, 0), "Re s", label_size, ink, anchor="end"))
        x, y = v(smin, tmax, 0)
        o.append(text((x + label_size * 0.4, y + label_size * 0.4), "Im s", label_size, ink))
        x, y = v(smin, 0, zmax)
        o.append(text((x, y - label_size * 0.5), "|ζ(s)|", label_size, ink, anchor="middle"))
    return o

def floor(v, smin, smax, tmax, w, soft=SOFT, accent=ACCENT):
    """The critical strip edges and the critical line on the floor."""
    o = []
    for sigma in (0.0, 1.0):
        o.append(line(v(sigma, 0, 0), v(sigma, tmax, 0), soft, w * 0.7, opacity=0.7))
    o.append(line(v(0.5, 0, 0), v(0.5, tmax, 0), accent, w, opacity=0.9))
    return o

def zeros(v, r, tmax, accent=ACCENT):
    return [f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{r}" fill="{accent}" stroke="none"/>'
            for x, y in (v(0.5, g, 0) for g in ZEROS if g <= tmax)]

def cover(path):
    W, H = 1200, 480
    tmax = 50
    v = View(scale=17.0, ox=215, oy=330, et=(1.0, -0.10), es=(-0.50, 0.30),
             sstretch=9.0, zstretch=6.5)
    # transparent, in light colours: the landing page shows it on a purple-to-cyan gradient
    ink, soft, accent = "#f8fafc", "#c7d2fe", "#fcd34d"
    o = []
    o += axes(v, -0.25, 1.45, tmax + 2, 2.4, 2, 20, ink=ink)
    o += floor(v, -0.25, 1.4, tmax, 1.6, soft=soft, accent=accent)
    # |ζ(1/2 + it)| along the critical line
    curve = [v(0.5, t / 20, height(0.5 + 1j * t / 20)) for t in range(0, tmax * 20 + 1)]
    o.append(f'<polyline points="{pts(curve)}" fill="none" stroke="{ink}" stroke-width="2.6" '
             'stroke-linejoin="round"/>')
    o += zeros(v, 5, tmax, accent=accent)
    return W, H, o

def background(path):
    """The plane seen from the top: level curves of log |ζ| (rings around the zeros and the
    pole) and curves of constant arg ζ (through the zeros), on a transparent background."""
    import cmath
    from contours import segments
    smin, smax, tmin, tmax = -6.8, 13.2, -3.0, 27.0
    step = 0.03
    limit = 2.7  # only where log |ζ| ≤ limit: away from the fast growth for re s < 0
    px = 2000 / (smax - smin)  # pixels per unit, the same in both directions
    W, H = 2000, round((tmax - tmin) * px)
    xs = [smin + step * i for i in range(round((smax - smin) / step) + 1)]
    ys = [tmin + step * j for j in range(round((tmax - tmin) / step) + 1)]
    vals = [[zeta(complex(x, y)) if abs(complex(x, y) - 1) > 1e-9 else None for x in xs]
            for y in ys]
    vals = [[None if v is None or v == 0 or math.log(abs(v)) > limit else v for v in row]
            for row in vals]
    logabs = [[None if v is None else math.log(abs(v)) for v in row] for row in vals]

    def to_px(p):
        return (p[0] - smin) * px, (tmax - p[1]) * px

    def path(segs, color, width, opacity):
        d = " ".join(f"M{to_px(a)[0]:.1f},{to_px(a)[1]:.1f}L{to_px(b)[0]:.1f},{to_px(b)[1]:.1f}"
                     for a, b in segs)
        return (f'<path d="{d}" fill="none" stroke="{color}" stroke-width="{width}" '
                f'stroke-opacity="{opacity}" stroke-linecap="round"/>')

    # mid-tones, as the transparent image is shown on light and on dark backgrounds
    ring, ray = "#64748b", "#94a3b8"
    o = []
    # the axes, the edge of the critical strip and the critical line
    o.append(line(to_px((smin, 0)), to_px((smax, 0)), ring, 2.5, opacity=0.8))
    o.append(line(to_px((0, tmin)), to_px((0, tmax)), ring, 2.5, opacity=0.8))
    o.append(line(to_px((1, tmin)), to_px((1, tmax)), SOFT, 2, opacity=0.6))
    o.append(line(to_px((0.5, tmin)), to_px((0.5, tmax)), ACCENT, 2.5, opacity=0.6))
    # curves of constant argument: Im(e^{-iθ} ζ) = 0 gives the arguments θ and θ + π
    for k in range(6):
        rot = cmath.exp(-1j * math.pi * k / 6)
        im = [[None if v is None else (rot * v).imag for v in row] for row in vals]
        o.append(path(segments(im, xs, ys, 0.0), ray, 1.6, 0.6))
    # level curves of log |ζ|: rings around the zeros and the pole
    for n in range(-28, 11):
        o.append(path(segments(logabs, xs, ys, n * 0.25), ring, 2.0, 0.85))
    # the zeros: trivial on the real axis, non-trivial on the critical line
    trivial = [complex(-2 * n, 0) for n in range(1, 4)]
    nontrivial = [complex(0.5, g) for g in ZEROS if g <= tmax]
    for z in trivial + nontrivial:
        x, y = to_px((z.real, z.imag))
        o.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="9" fill="{ACCENT}" stroke="none"/>')
    return W, H, o

def write(name, fn):
    W, H, o = fn(name)
    svg = (f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" '
           f'viewBox="0 0 {W} {H}">\n' + "\n".join(o) + "\n</svg>\n")
    open(name, "w").write(svg)

if __name__ == "__main__":
    write("cover.svg", cover)
    write("background.svg", background)
