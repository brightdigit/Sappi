import ArgumentParser

public enum RatioFormat: String, ExpressibleByArgument {
  case percent
  case ratio
  case `default`
  case percentTotal
}
