from gf import GF
from gf2 import GF2


class ParseState:
    value: int
    text: str
    isError: bool

    def __init__(self, text: str):
        self.value = int(text)
        self.text = ""
        self.isError = False

    def setNeg(self):
        if not self.isError:
            self.value = GF(-self.value).value()
            self.text = str(self.value) + " "

    def setNum(self):
        if not self.isError:
            self.value = GF(self.value).value()
            self.text = str(self.value) + " "

    def add(self, other: "ParseState") -> "ParseState":
        if other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF(self.value) + GF(other.value)).value()
            self.text += other.text + "+ "

        return self

# ParseState ParseState::sub(const ParseState& other) {
#   if (other.isError) {
#     this->text = other.text;
#     this->isError = true;
#   }

#   if (!this->isError) {
#     this->value = GF(this->value) - GF(other.value);
#     this->text = this->text + other.text + "- ";
#   }

#   return *this;
# }

# ParseState ParseState::mul(const ParseState& other) {
#   if (other.isError) {
#     this->text = other.text;
#     this->isError = true;
#   }

#   if (!this->isError) {
#     this->value = GF(this->value) * GF(other.value);
#     this->text = this->text + other.text + "* ";
#   }

#   return *this;
# }

# ParseState ParseState::div(const ParseState& other) {
#   if (other.isError) {
#     this->text = other.text;
#     this->isError = true;
#   }

#   if (!this->isError) {
#     try {
#       this->value = GF(this->value) / GF(other.value);
#       this->text = this->text + other.text + "/ ";
#     } catch (gf::GFNoInverseException) {
#       this->text = std::to_string(GF(other.value)) +
#                    " nie jest odwracalne modulo " +
#                    std::to_string(GF::MAX_VALUE);
#       this->isError = true;
#     }
#   }

#   return *this;
# }

# ParseState ParseState::neg() {
#   if (!this->isError) {
#     this->value = GF(-this->value);
#   }

#   return *this;
# }

# ParseState ParseState::exp(const ParseState& other) {
#   if (other.isError) {
#     this->text = other.text;
#     this->isError = true;
#   }

#   if (!this->isError) {
#     this->value = GF(this->value) ^ GF(other.value);
#     this->text = this->text + other.text + "^ ";
#   }

#   return *this;
# }

# ParseState ParseState::setNegExp() {
#   if (!this->isError) {
#     this->value = GF2(-this->value);
#     this->text = std::to_string(this->value) + ' ';
#   }

#   return *this;
# }

# ParseState ParseState::setNumExp() {
#   if (!this->isError) {
#     this->value = GF2(this->value);
#     this->text = std::to_string(this->value) + ' ';
#   }

#   return *this;
# }

# ParseState ParseState::addExp(const ParseState& other) {
#   if (other.isError) {
#     this->text = other.text;
#     this->isError = true;
#   }

#   if (!this->isError) {
#     this->value = GF2(this->value) + GF2(other.value);
#     this->text = this->text + other.text + "+ ";
#   }

#   return *this;
# }

# ParseState ParseState::subExp(const ParseState& other) {
#   if (other.isError) {
#     this->text = other.text;
#     this->isError = true;
#   }

#   if (!this->isError) {
#     this->value = GF2(this->value) - GF2(other.value);
#     this->text = this->text + other.text + "- ";
#   }

#   return *this;
# }

# ParseState ParseState::divExp(const ParseState& other) {
#   if (other.isError) {
#     this->text = other.text;
#     this->isError = true;
#   }

#   if (!this->isError) {
#     try {
#       this->value = GF2(this->value) / GF2(other.value);
#       this->text = this->text + other.text + "/ ";
#     } catch (gf::GFNoInverseException) {
#       this->text = std::to_string(GF2(other.value)) +
#                    " nie jest odwracalne modulo " +
#                    std::to_string(GF2::MAX_VALUE);
#       this->isError = true;
#     }
#   }

#   return *this;
# }

# ParseState ParseState::mulExp(const ParseState& other) {
#   if (other.isError) {
#     this->isError = true;
#   }

#   if (!this->isError) {
#     this->value = GF2(this->value) * GF2(other.value);
#     this->text = this->text + other.text + "* ";
#   }

#   return *this;
# }

# ParseState ParseState::negExp() {
#   if (!this->isError) {
#     this->value = GF2(-this->value);
#   }

#   return *this;
# }

# std::ostream& operator<<(std::ostream& os, const ParseState& ps) {
#   if (ps.isError) {
#     os << "> " << ps.text << '\n';
#   } else {
#     os << ps.text << "\n= " << ps.value << '\n';
#   }

#   return os;
