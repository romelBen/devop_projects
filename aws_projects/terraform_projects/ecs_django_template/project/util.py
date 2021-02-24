def candidate_marker(first_name, last_name):
    """
    Function to output a valid candidate marker.

    Arguments:
        first_name    - A first name
        last_name     - A last name

    Returns:
    A normalized first and last name string.
    """
    first_name = first_name if first_name else "firstname"
    last_name = last_name if last_name else "lastname"

    normalized_first_name = first_name.upper()
    normalized_last_name = last_name.upper()

    return "{0}_{1}".format(
        normalized_last_name,
        normalized_first_name
    )