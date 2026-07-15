# Absent values and errors in Mat2Ppt

Companion to [indexing.md](indexing.md). These rules make the toolbox feel like
normal MATLAB while staying aligned with python-pptx **behavior** and **package
output**.

## Absent values (`None` in python-pptx)

Where python-pptx accepts `None` to mean *clear / inherit / no explicit value*:

| You pass in MATLAB | Meaning |
|--------------------|---------|
| `[]` | Absent (always supported; used in docs and examples) |
| `missing` | Absent (also supported) |
| `""` | Empty **string**, not “absent” |

Examples (illustrative):

```matlab
font.bold = [];           % clear explicit bold (like bold = None in Python)
font.bold = missing;      % same effect as []
run.text = "";            % empty text content — not the same as absent
```

After clearing, **reading** an absent optional value returns **`[]`** (so
`isempty(x)` works). You do not need to handle `missing` on the way out.

## Errors

Failures raise MATLAB errors with:

1. A stable identifier: `mat2ppt:SomethingSpecific`  
2. A **clear English message** that helps you fix the call  

Example pattern:

```text
mat2ppt:IndexOutOfRange
Slide index 0 is out of range. Valid indices for this collection are 1 through 3 (1-based).
```

Catch by identifier when automating:

```matlab
try
    slides.item(0);
catch ME
    if ME.identifier == "mat2ppt:IndexOutOfRange"
        % handle
    else
        rethrow(ME);
    end
end
```

Messages are written for **people**. They use **1-based** index language. They
are not required to match python-pptx’s wording character-for-character.

## Properties

Most python-pptx `@property` accessors are **dependent properties** in Mat2Ppt:

```matlab
tf = shape.text_frame;           % get
prs.slide_width = Inches(10);  % set
```

Actions remain methods (`save`, `add_slide`, …).
