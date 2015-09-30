# Fact: dkmsversion
#
# Purpose: returns installed version of DKMS
#
# Resolution:
#
# Caveats:
#
#
Facter.add("dkmsversion") do
  confine :kernel => :linux
  setcode do
    out = Facter::Util::Resolution.exec("dkms --version 2>&1")
    if out =~/^dkms:\s+(.+)$/
      $1
    end
  end
end
