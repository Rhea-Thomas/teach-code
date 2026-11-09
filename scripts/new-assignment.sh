#!/usr/bin/env bash
# Scaffold an xUnit project for one assignment.
# Usage: new-assignment.sh <topic-dir> <NNNN-slug>
# Creates <topic-dir>/assignments/<NNNN-slug>/ with Starter.cs and StarterTests.cs.
# The placeholder test fails on purpose: replace it with tests for the "Done when" criteria.
set -euo pipefail

if [ $# -ne 2 ]; then echo "usage: $0 <topic-dir> <NNNN-slug>" >&2; exit 2; fi
if ! command -v dotnet >/dev/null 2>&1; then
  echo "dotnet SDK not found. Install it from https://dotnet.microsoft.com/download, then retry." >&2
  exit 1
fi

dir="$1/assignments/$2"
if [ -e "$dir" ]; then echo "$dir already exists" >&2; exit 1; fi
mkdir -p "$dir"
(cd "$dir" && dotnet new xunit --name "$2" --output . --no-restore >/dev/null && rm -f UnitTest1.cs)

cat > "$dir/Starter.cs" <<'EOF'
namespace Assignment;

// Write your solution here.
public static class Starter
{
    public static int Todo() => throw new NotImplementedException();
}
EOF

cat > "$dir/StarterTests.cs" <<'EOF'
using Assignment;
using Xunit;

public class StarterTests
{
    [Fact]
    public void Placeholder_ReplaceWithRealTests()
    {
        Assert.Equal(1, Starter.Todo());
    }
}
EOF

echo "Scaffolded $dir"
echo "Check it fails for the right reason: dotnet test $dir"
