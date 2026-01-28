$ErrorActionPreference="Stop"

# ---------------- CONFIG ----------------
$SiteTitle = "NEST"
$Tagline   = "Deterministic system constraints"
$Year      = (Get-Date).Year

$Nav = @(
  @{ t="Home";       h="index.html"      }
  @{ t="Product";    h="product.html"    }
  @{ t="Industries"; h="industries.html" }
  @{ t="Contact";    h="contact.html"    }
  @{ t="Impressum";  h="impressum.html"  }
)

function WriteUtf8([string]$Path,[string]$Content){
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText((Resolve-Path -LiteralPath $Path), $Content, $utf8NoBom)
}

function NavHtml([string]$active){
  ($Nav | ForEach-Object {
    $cls = if ($_.h -eq $active) { "active" } else { "" }
    "<a class=""$cls"" href=""$($_.h)"">$($_.t)</a>"
  }) -join ""
}

function Page([string]$active,[string]$title,[string]$desc,[string]$body){
@"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>$title</title>
  <meta name="description" content="$desc" />
  <link rel="stylesheet" href="style.css?v=8" />
</head>
<body>
<header class="topbar">
  <div class="wrap topbarInner">
    <a class="brand" href="index.html" aria-label="Home">
      <span class="mark" aria-hidden="true"></span>
      <span class="brandText">
        <span class="brandName">$SiteTitle</span>
        <span class="brandTag">$Tagline</span>
      </span>
    </a>
    <nav class="nav">
      $(NavHtml $active)
    </nav>
  </div>
</header>

<main class="wrap page">
$body
</main>

<footer class="footer">
  <div class="wrap footerInner">
    <div>© $Year $SiteTitle</div>
    <div class="footerLinks"><a href="impressum.html">Impressum</a></div>
  </div>
</footer>

<script src="script.js?v=8"></script>
</body>
</html>
"@
}

function RedirectPage([string]$to){
@"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <meta http-equiv="refresh" content="0; url=$to">
  <link rel="canonical" href="$to">
  <title>Redirecting…</title>
</head>
<body>
  <p>Redirecting… <a href="$to">Continue</a></p>
  <script>location.replace("$to");</script>
</body>
</html>
"@
}

# ---------------- STYLE ----------------
WriteUtf8 ".\style.css" @"
:root{
  --bg:#f6f8fb;
  --panel:#ffffff;
  --text:#15202b;
  --muted:#5d7286;
  --line:#dbe3ec;
  --teal:#0b7a7a;
  --teal2:#0a5f66;
  --shadow:0 12px 34px rgba(20,35,45,.08);
  --shadow2:0 8px 18px rgba(20,35,45,.10);
  --r:18px;
}
*{box-sizing:border-box}
html,body{height:100%}
body{
  margin:0;
  font-family:ui-sans-serif,system-ui,-apple-system,Segoe UI,Roboto,Arial,Helvetica Neue,Helvetica,sans-serif;
  color:var(--text);
  background:
    radial-gradient(1200px 650px at 15% -15%, rgba(11,122,122,.12), transparent 58%),
    radial-gradient(900px 520px at 95% 10%, rgba(11,122,122,.10), transparent 55%),
    var(--bg);
}
.wrap{max-width:1160px;margin:0 auto;padding:0 18px}
.page{padding:24px 0 38px}

.topbar{
  position:sticky;top:0;z-index:20;
  background:rgba(255,255,255,.82);
  backdrop-filter:blur(10px);
  border-bottom:1px solid var(--line);
}
.topbarInner{display:flex;align-items:center;justify-content:space-between;gap:18px;padding:14px 0}
.brand{display:flex;align-items:center;gap:12px;text-decoration:none;color:inherit}
.mark{
  width:36px;height:36px;border-radius:12px;
  background:linear-gradient(135deg, rgba(11,122,122,.24), rgba(11,122,122,.06));
  border:1px solid rgba(11,122,122,.28);
  box-shadow:var(--shadow2);
}
.brandText{display:flex;flex-direction:column;line-height:1.05}
.brandName{font-weight:800;letter-spacing:.18em}
.brandTag{font-size:12px;color:var(--muted)}
.nav{display:flex;gap:10px;flex-wrap:wrap;justify-content:flex-end}
.nav a{
  color:var(--muted);text-decoration:none;font-size:13px;
  padding:8px 10px;border-radius:12px;border:1px solid transparent;
}
.nav a:hover{color:var(--text);border-color:var(--line);background:rgba(255,255,255,.65)}
.nav a.active{color:var(--teal2);border-color:rgba(11,122,122,.22);background:rgba(11,122,122,.08)}

h1{margin:12px 0 10px;font-size:38px;letter-spacing:-.03em;line-height:1.08}
h2{margin:0;font-size:16px;letter-spacing:-.01em}
h3{margin:0;font-size:13px;letter-spacing:.12em;text-transform:uppercase;color:var(--teal2)}
.lead{margin:0 0 14px;color:var(--muted);font-size:15px;line-height:1.7}
.muted{margin:6px 0 0;color:var(--muted);font-size:13px;line-height:1.6}

.hero{
  display:grid;
  grid-template-columns:1.15fr .85fr;
  gap:16px;
  align-items:stretch;
  margin-top:10px;
}
.heroLeft,.heroRight{
  background:rgba(255,255,255,.78);
  border:1px solid var(--line);
  border-radius:var(--r);
  box-shadow:var(--shadow);
  padding:22px;
}
.eyebrow{
  display:inline-block;
  font-size:12px;
  letter-spacing:.16em;
  text-transform:uppercase;
  color:var(--teal2);
  background:rgba(11,122,122,.08);
  border:1px solid rgba(11,122,122,.18);
  padding:8px 10px;
  border-radius:999px;
}
.chipRow{display:flex;flex-wrap:wrap;gap:8px;margin-top:10px}
.chip{
  font-size:12px;padding:7px 10px;border-radius:999px;
  border:1px solid rgba(11,122,122,.18);
  background:rgba(11,122,122,.07);
  color:var(--teal2);
}
.ctaRow{display:flex;gap:10px;margin-top:14px;flex-wrap:wrap}
.btnPrimary,.btnGhost{
  display:inline-flex;align-items:center;justify-content:center;
  padding:11px 14px;border-radius:14px;text-decoration:none;font-weight:700;
  border:1px solid transparent;
}
.btnPrimary{background:linear-gradient(135deg, rgba(11,122,122,.92), rgba(10,95,102,.92));color:#fff;box-shadow:var(--shadow2)}
.btnPrimary:hover{filter:brightness(1.02)}
.btnGhost{background:rgba(255,255,255,.7);color:var(--teal2);border-color:rgba(11,122,122,.22)}
.btnGhost:hover{background:rgba(11,122,122,.06)}
.fineprint{margin-top:14px;color:var(--muted);font-size:12px;line-height:1.6}

.panel{
  border-radius:16px;
  border:1px solid rgba(11,122,122,.22);
  background:rgba(255,255,255,.60);
  padding:14px;
}
.panelTitle{font-size:12px;color:var(--muted);margin-bottom:10px}
.panelNote{font-size:12px;color:var(--muted);margin-top:10px}

.grid{
  margin-top:16px;
  display:grid;
  grid-template-columns:repeat(2, minmax(0,1fr));
  gap:14px;
}
.card{
  background:rgba(255,255,255,.86);
  border:1px solid var(--line);
  border-radius:var(--r);
  box-shadow:var(--shadow);
  padding:18px;
}
.cardHead{display:flex;gap:12px;align-items:flex-start;margin-bottom:10px}
.icon{
  width:42px;height:42px;border-radius:14px;
  display:flex;align-items:center;justify-content:center;
  background:linear-gradient(135deg, rgba(11,122,122,.18), rgba(11,122,122,.06));
  border:1px solid rgba(11,122,122,.25);
  color:var(--teal2);
  font-weight:900;
  letter-spacing:.08em;
}
.bullets{margin:12px 0 0;padding-left:18px;color:var(--muted);font-size:13px;line-height:1.65}
.bullets li{margin:6px 0}
.bullets b{color:var(--text);font-weight:750}

.callout{
  margin-top:16px;
  background:rgba(11,122,122,.07);
  border:1px solid rgba(11,122,122,.18);
  border-radius:var(--r);
  padding:18px;
}
.callout p{margin:8px 0 0;color:var(--muted);font-size:13px;line-height:1.7}

.footer{border-top:1px solid var(--line);background:rgba(255,255,255,.78)}
.footerInner{display:flex;align-items:center;justify-content:space-between;gap:12px;padding:16px 0;color:var(--muted);font-size:13px}
.footerLinks a{
  color:var(--teal2);
  text-decoration:none;
  padding:8px 10px;
  border-radius:12px;
  border:1px solid rgba(11,122,122,.18);
  background:rgba(11,122,122,.06);
}
.footerLinks a:hover{background:rgba(11,122,122,.10)}

@media (max-width:980px){
  .topbarInner{flex-direction:column;align-items:flex-start}
  .nav{justify-content:flex-start}
  .hero{grid-template-columns:1fr}
  .grid{grid-template-columns:1fr}
  h1{font-size:32px}
}
"@

# ---------------- SCRIPT ----------------
WriteUtf8 ".\script.js" @"
(() => {
  document.addEventListener("click", (e) => {
    const a = e.target.closest("a[href^='#']");
    if (!a) return;
    const id = a.getAttribute("href").slice(1);
    const el = document.getElementById(id);
    if (!el) return;
    e.preventDefault();
    el.scrollIntoView({ behavior: "smooth", block: "start" });
  });
})();
"@

$LegalBlock = "NEST introduces deterministic structural constraints on system behavior. Observable effects depend on system context and workload. No performance or outcome guarantees are implied beyond bounded behavior and non-propagation of instability."

$HomeBody = @"
<section class="hero">
  <div class="heroLeft">
    <div class="eyebrow">NEXT-GEN RELIABILITY LAYER</div>
    <h1>Bound system behavior. Prevent instability from propagating.</h1>
    <p class="lead">
      NEST is a deterministic, non-adaptive system constraint. It does not rely on prediction, learning, or feedback.
      Effects are structural: when enabled, instability remains local and cannot sustain uncontrolled propagation.
    </p>
    <div class="chipRow">
      <span class="chip">Deterministic</span>
      <span class="chip">Bounded</span>
      <span class="chip">Prevents propagation</span>
      <span class="chip">Non-adaptive</span>
      <span class="chip">No prediction</span>
    </div>
    <div class="ctaRow">
      <a class="btnPrimary" href="product.html">Product overview</a>
      <a class="btnGhost" href="industries.html">Industry examples</a>
    </div>
    <div class="fineprint">$LegalBlock</div>
  </div>
  <div class="heroRight">
    <div class="panel">
      <div class="panelTitle">Illustrative (not measured data)</div>
      <div class="panelNote">
        Visual metaphor: bounded regions, truncated tails, and local disturbances that do not spread.
      </div>
    </div>
  </div>
</section>

<section class="grid">
  <article class="card">
    <div class="cardHead"><div class="icon">IS</div><div><h2>What it is</h2><div class="muted">A constraint layer above domain logic and before escalation.</div></div></div>
    <ul class="bullets">
      <li><b>Constrains</b> system evolution under uncertainty.</li>
      <li><b>Bounds</b> worst-case behavior (structural framing, not performance claims).</li>
      <li><b>Deterministic</b> and repeatable by design.</li>
    </ul>
  </article>
  <article class="card">
    <div class="cardHead"><div class="icon">NO</div><div><h2>What it is not</h2><div class="muted">Not a monitoring product; not a performance optimizer; not AI.</div></div></div>
    <ul class="bullets">
      <li>No learning, no adaptive drift, no prediction.</li>
      <li>No “magic” benchmarks or universal percentage claims.</li>
      <li>Describes outcomes without disclosing implementation details.</li>
    </ul>
  </article>
</section>

<section class="callout">
  <h3> framing</h3>
  <p>$LegalBlock</p>
</section>
"@

$ProductBody = @"
<section class="hero">
  <div class="heroLeft">
    <div class="eyebrow">PRODUCT</div>
    <h1>NEST: deterministic constraints under uncertainty</h1>
    <p class="lead">
      NEST sits above domain logic and before escalation. It constrains and bounds how instability can evolve,
      preventing propagation beyond its origin. It is non-adaptive and deterministic.
    </p>
    <div class="chipRow">
      <span class="chip">Structural</span>
      <span class="chip">Deterministic</span>
      <span class="chip">Non-adaptive</span>
      <span class="chip">Repeatable</span>
    </div>
  </div>
  <div class="heroRight">
    <div class="panel">
      <div class="panelTitle">What the site discloses</div>
      <div class="panelNote">
        High-level positioning and effects only. No implementation details; controlled disclosure is NDA-first.
      </div>
    </div>
  </div>
</section>

<section class="grid">
  <article class="card">
    <div class="cardHead"><div class="icon">CH</div><div><h2>What NEST changes</h2><div class="muted">Illustrative before / after structure</div></div></div>
    <ul class="bullets">
      <li><b>Without:</b> cascades, retry storms, tail amplification.</li>
      <li><b>With:</b> bounded behavior; disturbance remains local; propagation is prevented.</li>
      <li><b>Result:</b> smoother recovery and fewer “system-wide” instability modes.</li>
    </ul>
  </article>
  <article class="card">
    <div class="cardHead"><div class="icon">GL</div><div><h2>Guarantees and limits</h2><div class="muted">Structural guarantees only</div></div></div>
    <ul class="bullets">
      <li><b>Guarantees:</b> bounded behavior and non-propagation categories (structural).</li>
      <li><b>Not guaranteed:</b> performance, outcomes, prediction, or universal improvements.</li>
      <li><b>Depends on:</b> integration boundary and workload context.</li>
    </ul>
  </article>
</section>

<section class="callout">
  <h3>Deployment posture</h3>
  <p>Deployed as a small system-level layer. Can be enabled/disabled. Integrates incrementally and does not replace existing systems.</p>
</section>
"@

$IndustriesBody = @"
<section class="hero">
  <div class="heroLeft">
    <div class="eyebrow">INDUSTRIES</div>
    <h1>Same mechanism category. Different failure surfaces.</h1>
    <p class="lead">
      Examples are framed as recognizable failure situations and structural effects. All graphs and examples are illustrative (shape-based), not benchmark claims.
    </p>
    <div class="chipRow">
      <span class="chip">Bound worst-case</span>
      <span class="chip">Prevent propagation</span>
      <span class="chip">Deterministic</span>
    </div>
  </div>
  <div class="heroRight">
    <div class="panel">
      <div class="panelTitle">Rule</div>
      <div class="panelNote">No numbers unless explicitly labeled “typical”. No hype visuals. No benchmark leaderboards.</div>
    </div>
  </div>
</section>

<section class="grid">
  <article class="card">
    <div class="cardHead"><div class="icon">FX</div><div><h2>Financial trading and market infrastructure</h2><div class="muted">Order routing, gateways, risk checks</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> tail spikes, retry storms, queue avalanches during volatility.</li>
      <li><b>With NEST:</b> escalation is contained; worst-case behavior is bounded.</li>
      <li><b>Prevents:</b> local faults becoming market-wide instability modes.</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">CL</div><div><h2>Cloud platforms and SRE-critical services</h2><div class="muted">Control planes, multi-tenant services</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> thundering herds, overload loops, cascading timeouts.</li>
      <li><b>With NEST:</b> amplification is bounded; issues remain local.</li>
      <li><b>Prevents:</b> region-wide propagation from a single hot path.</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">TL</div><div><h2>Telecom and real-time networks</h2><div class="muted">Core signaling, VoIP backbones</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> congestion spirals, retransmit storms, control-plane overload.</li>
      <li><b>With NEST:</b> bounded degradation; instability does not propagate.</li>
      <li><b>Prevents:</b> localized congestion becoming systemic collapse.</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">EN</div><div><h2>Energy and grid-adjacent control systems</h2><div class="muted">Protection layers, dispatch interfaces</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> oscillatory recovery, cascading trips under uncertainty.</li>
      <li><b>With NEST:</b> bounded recovery behavior; propagation channels constrained.</li>
      <li><b>Prevents:</b> local disturbances escalating into multi-node instability.</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">HX</div><div><h2>Healthcare IT and hospital operations</h2><div class="muted">Scheduling, imaging pipelines, EHR workflows</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> backlog avalanches, error cascades across dependent services.</li>
      <li><b>With NEST:</b> bounded failure behavior; local issues remain local.</li>
      <li><b>Prevents:</b> systemic operational instability during peak demand.</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">AV</div><div><h2>Aviation and safety-critical operations</h2><div class="muted">Coordination layers, dispatch systems</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> compounding delays, brittle recovery after disruptions.</li>
      <li><b>With NEST:</b> bounded recovery envelope; no runaway escalation loops.</li>
      <li><b>Prevents:</b> local faults triggering system-wide instability.</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">MN</div><div><h2>Manufacturing and industrial automation</h2><div class="muted">Line control, scheduling, QA pipelines</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> oscillation between states, brittle re-planning cascades.</li>
      <li><b>With NEST:</b> bounded transitions; propagation between modules constrained.</li>
      <li><b>Prevents:</b> localized faults becoming plant-wide instability modes.</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">LG</div><div><h2>Logistics and supply chain orchestration</h2><div class="muted">Routing, warehouse execution</div></div></div>
    <ul class="bullets">
      <li><b>Failure:</b> cascade of re-routes, backlog explosions, brittle recovery.</li>
      <li><b>With NEST:</b> bounded reconfiguration; local disruptions do not propagate.</li>
      <li><b>Prevents:</b> runaway “re-plan storms” under uncertainty.</li>
    </ul>
  </article>
</section>

<section class="callout">
  <h3>Graph rule</h3>
  <p>Any illustrative graphic must be labeled “Illustrative”, shape-based, and show before/after structure (e.g., truncated tails), not improvement hype.</p>
</section>
"@

$ContactBody = @"
<section class="hero">
  <div class="heroLeft">
    <div class="eyebrow">ENGAGEMENT</div>
    <h1>Serious technical inquiries only</h1>
    <p class="lead">
      NEST is discussed under controlled engagement. Initial contact should be high-level; technical disclosure is NDA-first.
    </p>
    <div class="chipRow">
      <span class="chip">NDA-first</span>
      <span class="chip">No public demos</span>
      <span class="chip">No replication details</span>
    </div>
  </div>
  <div class="heroRight">
    <div class="panel">
      <div class="panelTitle">Contact</div>
      <div class="panelNote">Use your preferred channels below.</div>
    </div>
  </div>
</section>

<section class="grid">
  <article class="card">
    <div class="cardHead"><div class="icon">EM</div><div><h2>Email</h2><div class="muted"><a href="mailto:contact@boundedsystem.com">contact@boundedsystem.com</a></div></div></div>
    <ul class="bullets">
      <li>Include organization, system category, and failure surfaces you care about.</li>
      <li>Avoid code, architecture, or proprietary details in first contact.</li>
    </ul>
  </article>
  <article class="card">
    <div class="cardHead"><div class="icon">PR</div><div><h2>Process</h2><div class="muted">Controlled disclosure</div></div></div>
    <ul class="bullets">
      <li>Initial screening: fit and seriousness.</li>
      <li>NDA: controlled disclosure.</li>
      <li>Technical session: scope and integration boundary.</li>
    </ul>
  </article>
</section>

<section class="callout">
  <h3>Legal</h3>
  <p>$LegalBlock</p>
</section>
"@

$ImpressumBody = @"
<section class="hero">
  <div class="heroLeft">
    <div class="eyebrow">LEGAL</div>
    <h1>Impressum</h1>
    <p class="lead">Provider information and legal notices.</p>
    <p class="muted">Replace the placeholders below with your correct legal entity details.</p>
  </div>
  <div class="heroRight">
    <div class="panel">
      <div class="panelTitle">Notice</div>
      <div class="panelNote">This page is intentionally minimal.</div>
    </div>
  </div>
</section>

<section class="grid">
  <article class="card">
    <div class="cardHead"><div class="icon">ID</div><div><h2>Provider</h2><div class="muted">Required fields depend on jurisdiction</div></div></div>
    <ul class="bullets">
      <li><b>Company / Name:</b> [YOUR LEGAL NAME]</li>
      <li><b>Address:</b> [STREET, CITY, POSTCODE, COUNTRY]</li>
      <li><b>Email:</b> <a href="mailto:contact@boundedsystem.com">contact@boundedsystem.com</a></li>
      <li><b>Phone:</b> [OPTIONAL]</li>
      <li><b>Registration:</b> [OPTIONAL / IF APPLICABLE]</li>
      <li><b>VAT ID:</b> [OPTIONAL / IF APPLICABLE]</li>
    </ul>
  </article>

  <article class="card">
    <div class="cardHead"><div class="icon">DS</div><div><h2>Disclaimer</h2><div class="muted">Scope</div></div></div>
    <ul class="bullets">
      <li>Information is provided for general informational purposes.</li>
      <li>No warranties as to completeness or accuracy.</li>
      <li>$LegalBlock</li>
    </ul>
  </article>
</section>
"@

# ---------------- WRITE PAGES ----------------
WriteUtf8 ".\index.html"      (Page "index.html"      "NEST — Deterministic System Constraints" "Deterministic, non-adaptive constraint layer that bounds worst-case behavior and prevents propagation of instability." $HomeBody)
WriteUtf8 ".\product.html"    (Page "product.html"    "Product — NEST" "Product overview: deterministic, bounded, non-adaptive constraint layer;  framing." $ProductBody)
WriteUtf8 ".\industries.html" (Page "industries.html" "Industries — NEST" "Industry examples framed as failure situations and structural effects; illustrative only." $IndustriesBody)
WriteUtf8 ".\contact.html"    (Page "contact.html"    "Contact — NEST" "Serious inquiries; NDA-first engagement." $ContactBody)
WriteUtf8 ".\impressum.html"  (Page "impressum.html"  "Impressum — NEST" "Provider information and legal notice." $ImpressumBody)

# ---------------- REDIRECT LEGACY PAGES ----------------
$redirects = @(
  "what.html","changes.html","guarantees.html","status.html","deploy.html","press.html","science.html",
  "product-page.html","deploy-model.html","scientific.html"
)
foreach($r in $redirects){
  WriteUtf8 (".\" + $r) (RedirectPage "product.html")
}

# ---------------- 404 ----------------
WriteUtf8 ".\404.html" (Page "index.html" "Not found — NEST" "Page not found." @"
<section class="hero">
  <div class="heroLeft">
    <div class="eyebrow">404</div>
    <h1>Page not found</h1>
    <p class="lead">The page you requested does not exist.</p>
    <div class="ctaRow">
      <a class="btnPrimary" href="index.html">Go home</a>
      <a class="btnGhost" href="product.html">Product</a>
    </div>
  </div>
  <div class="heroRight">
    <div class="panel">
      <div class="panelTitle">Tip</div>
      <div class="panelNote">Old links are redirected to Product.</div>
    </div>
  </div>
</section>
"@)

"OK"


