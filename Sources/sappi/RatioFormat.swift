import ArgumentParser

/**
 Different formats for displaying ratios.
 */
public enum RatioFormat: String, ExpressibleByArgument {
  /**
   Percent value.
   */
  case percent
  /**
   Displays the ratio as units / total units.
   */
  case ratio
  /**
   Uses the default format of system information component.
   */
  case `default`
  /**
   Displays the ratio as percent / total units.
   */
  case percentTotal
}
