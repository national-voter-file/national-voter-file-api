defmodule NationalVoterFile.UserTest do
  use NationalVoterFile.ModelCase

  alias NationalVoterFile.User

  @valid_attrs %{email: "test@user.com", password: "somepassword"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with invalid email" do
    attrs = Map.put(@valid_attrs, :email, "notanemail")
    changeset = User.changeset(%User{}, attrs)
    assert_error_message(changeset, :email, "has invalid format")
  end

  describe "registration_changeset" do
    test "password must be at least 6 chars long" do
      attrs = Map.put(@valid_attrs, :password, "12345")
      changeset = User.registration_changeset(%User{}, attrs)
      assert {:password, {"should be at least %{count} character(s)", [count: 6, validation: :length, min: 6]}} in changeset.errors
    end

    test "with valid attributes hashes password" do
      attrs = Map.put(@valid_attrs, :password, "123456")
      changeset = User.registration_changeset(%User{}, attrs)
      %{password: pass, encrypted_password: encrypted_password} = changeset.changes
      assert changeset.valid?
      assert encrypted_password
      assert Comeonin.Bcrypt.checkpw(pass, encrypted_password)
    end

    test "does not allow duplicate emails" do
      user_1_attrs = %{email: "duplicate@email.com", password: "password"}
      user_2_attrs = %{email: "duplicate@email.com", password: "password"}
      insert(:user, user_1_attrs)
      changeset = User.registration_changeset(%User{}, user_2_attrs)
      {:error, changeset} = Repo.insert(changeset)
      refute changeset.valid?
      assert_error_message(changeset, :email, "has already been taken")
    end
  end
end
